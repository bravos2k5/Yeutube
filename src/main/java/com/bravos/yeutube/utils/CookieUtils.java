package com.bravos.yeutube.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtils {

    public static Cookie getCookie(String name, Cookie[] cookies) {
        for (Cookie cookie : cookies) {
            if(cookie.getName().equals(name)) {
                return cookie;
            }
        }
        return null;
    }

    public static void deleteCookie(String name, HttpServletResponse response) {
        Cookie cookie = new Cookie(name,"");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

}
