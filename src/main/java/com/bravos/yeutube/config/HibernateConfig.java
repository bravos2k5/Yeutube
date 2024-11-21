package com.bravos.yeutube.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;


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
        return entityManagerFactory.createEntityManager();
    }

    public static void shutdown() {
        try {
            entityManagerFactory.close();
            System.out.println("Database connection closed");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
