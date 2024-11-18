package com.bravos.yeutube.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.hibernate.HibernateException;

public class HibernateConfig {

    private final static EntityManagerFactory entityManagerFactory = buildEntityManagerFactory();

    private static EntityManagerFactory buildEntityManagerFactory() {
        try {
            return Persistence.createEntityManagerFactory("default");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static EntityManager entityManager() {
        try {
            return entityManagerFactory.createEntityManager();
        } catch (HibernateException e) {
            throw new RuntimeException(e);
        }
    }

    public static void shutdown() {
        try {
            entityManagerFactory.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
