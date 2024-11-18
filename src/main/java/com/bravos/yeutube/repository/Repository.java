package com.bravos.yeutube.repository;

import com.bravos.yeutube.config.HibernateConfig;
import jakarta.persistence.*;

import java.util.*;


public abstract class Repository<T,ID> {

    private final Class<T> clazz;

    public Repository(Class<T> clazz) {
        this.clazz = clazz;
    }

    public final T findById(ID id, String... lazyLoaders) {
        String hql = "FROM " + clazz.getName() + " e WHERE e.id = :id";
        Map<String,Object> params = new HashMap<>();
        params.put("id",id);
        List<T> listQuery = executeQuery(hql,params,lazyLoaders);
        return listQuery.isEmpty() ? null : listQuery.getFirst();
    }

    public final List<T> findAll(String...lazyLoaders) {
        String hql = "FROM " + clazz.getName() + " e";
        return executeQuery(hql,null,lazyLoaders);
    }

    public final List<T> findAll(int offset, int limit, String...lazyLoaders) {
        String hql = "FROM " + clazz.getName() + " e";
        return executeQuery(hql,null,offset,limit,lazyLoaders);
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
            throw new RuntimeException(e);
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

    protected final List<T> findByHql(String hql, Map<String, Object> args, String... lazyLoaders) {
        return executeQuery(hql,args,lazyLoaders);
    }

    protected final List<T> findByHql(String hql, Map<String, Object> args, int offset, int limit, String... lazyLoaders) {
        return executeQuery(hql,args,offset,limit,lazyLoaders);
    }

    protected <X> List<X> executeHqlSingleData(String hql, Class<X> clazz) {
        return executeHqlSingleData(hql,null,clazz);
    }

    protected <X> List<X> executeHqlSingleData(String hql, Map<String,Object> params, Class<X> clazz) {
        try(EntityManager entityManager = HibernateConfig.entityManager()) {
            TypedQuery<X> query = entityManager.createQuery(hql,clazz);
            if (params != null) {
                params.forEach((key, value) -> {
                    if(key != null && !key.isBlank()) {
                        query.setParameter(key,value);
                    }
                });
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


    private List<T> executeQuery(String hql, Map<String,Object> params , String... lazyLoaders) {
        return executeQuery(hql,params,0,0,lazyLoaders);
    }

    // Nếu dùng lazyLoaders alias phải là e
    private List<T> executeQuery(String hql, Map<String, Object> params, int offset, int limit, String... lazyLoaders) {
        try (EntityManager entityManager = HibernateConfig.entityManager()) {

            StringBuilder queryBuilder;

            if (lazyLoaders != null && lazyLoaders.length > 0) {

                String[] mainParts = hql.split("(?i)\\b(order by|group by|having|where)\\b");
                queryBuilder = new StringBuilder(mainParts[0].trim());
                Set<String> uniqueLoaders = new HashSet<>(Arrays.asList(lazyLoaders));
                for (String lazyLoader : uniqueLoaders) {
                    if (lazyLoader != null) {
                        queryBuilder.append(" LEFT JOIN FETCH e.").append(lazyLoader);
                    }
                }
                for (int i = 1; i < mainParts.length; i++) {
                    queryBuilder.append(" ").append(hql, hql.indexOf(mainParts[i - 1]) + mainParts[i - 1].length(),
                            hql.indexOf(mainParts[i])).append(" ").append(mainParts[i].trim());
                }

            }
            else {
                queryBuilder = new StringBuilder(hql);
            }

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
