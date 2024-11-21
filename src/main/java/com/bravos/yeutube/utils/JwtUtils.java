package com.bravos.yeutube.utils;

import com.bravos.yeutube.dto.UserInfo;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;

import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

public class JwtUtils {

    private static final PrivateKey privateKey = PemUtils.loadPrivateKey(System.getenv("PRIVATE_KEY_PATH"),"16122005");
    private static final PublicKey publicKey = PemUtils.loadPublicKey(System.getenv("PUBLIC_KEY_PATH"));

    public static String generateToken(UserInfo user, long tokenExp) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("sub", user.getId());
        claims.put("role",user.getAdmin() ? "ADMIN" : "USER");
        claims.put("created", new Date());
        return Jwts.builder()
                .claims()
                .add(claims)
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + tokenExp))
                .and()
                .signWith(privateKey, Jwts.SIG.RS256)
                .compact();
    }

    public static Claims extractAllClaims(String token) {
        try {
            return Jwts.parser()
                    .verifyWith(publicKey)
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();
        } catch (JwtException | IllegalArgumentException e) {
            return null;
        }
    }

    public static  <T> T extractClaims(String token, Function<Claims,T> claimsResolver) {
        return claimsResolver.apply(extractAllClaims(token));
    }

    public static String extractUsername(String token) {
        try {
            return extractClaims(token,Claims::getSubject);
        } catch (Exception e) {
            return null;
        }
    }

    public static UserInfo extractUserInfoIfValid(String token) {
        String username = JwtUtils.extractUsername(token);
        UserInfo userInfo = null;
        if(JwtUtils.isValid(token,username)) {
            Claims claims = extractAllClaims(token);
            if(claims == null) return null;
            userInfo = new UserInfo();
            userInfo.setId(username);
            userInfo.setAdmin(claims.get("role", String.class).equals("ADMIN"));
        }
        return userInfo;
    }

    public static boolean isTokenExp(String token) {
        try {
            return extractClaims(token,Claims::getExpiration).before(new Date());
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isValid(String token, String username) {
        try {
            if(token == null || username == null || token.isBlank() || username.isBlank()) {
                return false;
            }
            Claims claims = extractAllClaims(token);
            if(claims == null) return false;
            Date exp = claims.getExpiration();
            String tokenName = claims.getSubject();
            return exp.after(new Date()) && tokenName.equals(username);
        } catch (Exception e) {
            return false;
        }
    }

}
