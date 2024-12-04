package com.bravos.yeutube.repository;

import com.bravos.yeutube.config.HibernateConfig;
import jakarta.persistence.*;

import java.util.*;


public abstract class Repository<T,ID> {

    private final Class<T> clazz;

    public Repository(Class<T> clazz) {
        this.clazz = clazz;
    }

    public final T findById(ID id) {
        String hql = "FROM " + clazz.getName() + " e WHERE e.id = :id";
        Map<String,Object> params = new HashMap<>();
        params.put("id",id);
        List<T> listQuery = executeQuery(hql,params);
        return listQuery.isEmpty() ? null : listQuery.getFirst();
    }

    public final List<T> findAll() {
        String hql = "FROM " + clazz.getName() + " e";
        return executeQuery(hql,null);
    }

    public final List<T> findAll(int offset, int limit) {
        String hql = "FROM " + clazz.getName() + " e";
        return executeQuery(hql,null,offset,limit);
    }

    public final T insert(T object) {

        EntityTransaction transaction = null;
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(object);
            transaction.commit();
            return object;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            return null;
        }

    }

    public Long countAll() {
        String hql = "SELECT COUNT(e) FROM " + clazz.getName() + " e";
        return executeHqlSingleData(hql,Long.class).getFirst();
    }

    public final void insert(T[] objects) {
        EntityTransaction transaction = null;
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            transaction = entityManager.getTransaction();
            transaction.begin();

            int batchSize = 50;

            for(int i = 0; i < objects.length; i++) {
                entityManager.persist(objects[i]);
                if((i + 1) % batchSize == 0 || i == objects.length - 1) {
                    entityManager.flush();
                    entityManager.clear();
                }
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }


    public final T update(T object) {
        EntityTransaction transaction = null;
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(object);
            transaction.commit();
            return object;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return null;
        }
    }


    public final void delete(ID id) {
        EntityTransaction transaction = null;
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            transaction = entityManager.getTransaction();
            Object o = entityManager.find(clazz,id);
            if(o == null) {
                return;
            }
            transaction.begin();
            entityManager.remove(o);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException(e);
        }
    }

    protected final <X> List<X> findByProcedure(String procedureName, Class<X> clazz) {
        return findByProcedure(procedureName,null,clazz);
    }

    private <X> StoredProcedureQuery storedProcQueryGenerator(EntityManager entityManager, String procedureName, Map<String, Object> args, Class<X> clazz) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery(procedureName, clazz);
        if (args != null) {
            for(var entry : args.entrySet()) {
                query.registerStoredProcedureParameter(entry.getKey(),entry.getValue().getClass(),ParameterMode.IN);
                query.setParameter(entry.getKey(),entry.getValue());
            }
        }
        return query;
    }

    protected final <X> int executeProcedure(String procedureName, Map<String, Object> args, Class<X> clazz) {
        EntityTransaction transaction = null;
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            transaction = entityManager.getTransaction();
            transaction.begin();
            StoredProcedureQuery query = storedProcQueryGenerator(entityManager,procedureName,args, clazz);
            int res = query.executeUpdate();
            transaction.commit();
            return res;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException(e);
        }
    }

    protected final <X> List<X> findByProcedure(String procedureName, Map<String, Object> args, Class<X> clazz) {
        EntityTransaction transaction = null;
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            transaction = entityManager.getTransaction();
            transaction.begin();
            StoredProcedureQuery query = storedProcQueryGenerator(entityManager,procedureName,args,clazz);
            List<X> list = query.getResultList();
            transaction.commit();
            return list;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException(e);
        }
    }

    protected final List<T> findByHql(String hql, Map<String, Object> args) {
        return executeQuery(hql,args);
    }

    protected final List<T> findByHql(String hql, Map<String, Object> args, int offset, int limit) {
        return executeQuery(hql,args,offset,limit);
    }

    protected <X> List<X> executeHqlSingleData(String hql, Class<X> clazz) {
        return executeHqlSingleData(hql,null,clazz);
    }

    protected <X> List<X> executeHqlSingleData(String hql, Map<String,Object> params, Class<X> clazz) {
        return executeHqlSingleData(hql,params,0,0,clazz);
    }

    protected <X> List<X> executeHqlSingleData(String hql, int offset, int limit, Class<X> clazz) {
        return executeHqlSingleData(hql,null,offset,limit,clazz);
    }

    protected <X> List<X> executeHqlSingleData(String hql, Map<String,Object> params, int offset, int limit, Class<X> clazz) {
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            TypedQuery<X> query = entityManager.createQuery(hql,clazz);
            if (params != null) {
                params.forEach((key, value) -> {
                    if(key != null && !key.isBlank()) {
                        query.setParameter(key,value);
                    }
                });
            }
            if (offset > 0) {
                query.setFirstResult(offset);
            }
            if (limit > 0) {
                query.setMaxResults(limit);
            }
            return query.getResultList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected int executeUpdate(String hql, Map<String,Object> params) {
        EntityTransaction transaction = null;
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createQuery(hql);
            params.forEach(query::setParameter);
            int affectedRow = query.executeUpdate();
            transaction.commit();
            return affectedRow;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException(e);
        }
    }


    private List<T> executeQuery(String hql, Map<String,Object> params) {
        return executeQuery(hql,params,0,0);
    }

    private List<T> executeQuery(String hql, Map<String, Object> params, int offset, int limit) {
        try (EntityManager entityManager = HibernateConfig.entityManager()) {

            StringBuilder queryBuilder;
            queryBuilder = new StringBuilder(hql);

            TypedQuery<T> query = entityManager.createQuery(queryBuilder.toString(), clazz);

            if (params != null) {
                for (var entry : params.entrySet()) {
                    query.setParameter(entry.getKey(), entry.getValue());
                }
            }

            if (offset > 0) {
                query.setFirstResult(offset);
            }
            if (limit > 0) {
                query.setMaxResults(limit);
            }

            return query.getResultList();
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Lỗi khởi tạo HQL: " + e.getMessage(), e);
        }

    }


}
