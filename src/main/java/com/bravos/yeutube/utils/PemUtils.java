package com.bravos.yeutube.utils;

import org.bouncycastle.asn1.pkcs.PrivateKeyInfo;
import org.bouncycastle.asn1.x509.SubjectPublicKeyInfo;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.openssl.PEMDecryptorProvider;
import org.bouncycastle.openssl.PEMEncryptedKeyPair;
import org.bouncycastle.openssl.PEMKeyPair;
import org.bouncycastle.openssl.PEMParser;
import org.bouncycastle.openssl.jcajce.JcaPEMKeyConverter;
import org.bouncycastle.openssl.jcajce.JceOpenSSLPKCS8DecryptorProviderBuilder;
import org.bouncycastle.openssl.jcajce.JcePEMDecryptorProviderBuilder;
import org.bouncycastle.operator.InputDecryptorProvider;
import org.bouncycastle.operator.OperatorCreationException;
import org.bouncycastle.pkcs.PKCS8EncryptedPrivateKeyInfo;
import org.bouncycastle.pkcs.PKCSException;

import java.io.FileReader;
import java.io.IOException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Security;

public class PemUtils {

    static {
        Security.addProvider(new BouncyCastleProvider());
    }

    public static PrivateKey loadPrivateKey(String filename, String password) {
        try (FileReader fileReader = new FileReader(filename)) {
            PEMParser pemParser = new PEMParser(fileReader);
            JcaPEMKeyConverter converter = new JcaPEMKeyConverter();
            Object object = pemParser.readObject();
            switch (object) {
                case PKCS8EncryptedPrivateKeyInfo pkcs8EncryptedPrivateKeyInfo -> {
                    InputDecryptorProvider provider = new JceOpenSSLPKCS8DecryptorProviderBuilder()
                            .setProvider("BC")
                            .build(password.toCharArray());
                    return converter.getPrivateKey(pkcs8EncryptedPrivateKeyInfo.decryptPrivateKeyInfo(provider));
                }
                case PEMEncryptedKeyPair pemEncryptedKeyPair -> {
                    PEMDecryptorProvider provider = new JcePEMDecryptorProviderBuilder()
                            .setProvider("BC")
                            .build(password.toCharArray());
                    PEMKeyPair keyPair = pemEncryptedKeyPair.decryptKeyPair(provider);
                    return converter.getPrivateKey(keyPair.getPrivateKeyInfo());
                }
                case PEMKeyPair pemKeyPair -> {
                    PrivateKeyInfo privateKeyInfo = pemKeyPair.getPrivateKeyInfo();
                    return converter.getPrivateKey(privateKeyInfo);
                }
                case PrivateKeyInfo privateKeyInfo -> {
                    return converter.getPrivateKey(privateKeyInfo);
                }
                default -> throw new RuntimeException("Unknown object type: " + object.getClass().getName());
            }
        } catch (IOException | OperatorCreationException | PKCSException e) {
            throw new RuntimeException(e);
        }
    }

    public static PublicKey loadPublicKey(String filename) {
        try (FileReader fileReader = new FileReader(filename)) {
            PEMParser pemParser = new PEMParser(fileReader);
            JcaPEMKeyConverter converter = new JcaPEMKeyConverter();
            Object object = pemParser.readObject();
            return converter.getPublicKey(SubjectPublicKeyInfo.getInstance(object));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}
