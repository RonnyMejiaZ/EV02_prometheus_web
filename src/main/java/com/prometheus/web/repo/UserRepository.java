package com.prometheus.web.repo;
import com.prometheus.web.model.User;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;
public class UserRepository {
  private static final Map<String, User> USERS = new ConcurrentHashMap<>();
  public static boolean save(User u){
    if(u==null || u.getEmail()==null) return false;
    if(USERS.containsKey(u.getEmail())) return false;
    USERS.put(u.getEmail(), u); return true;
  }
  public static boolean validate(String email, String pass){
    if(email==null || pass==null) return false;
    User u = USERS.get(email); return u!=null && u.getPassword().equals(pass);
  }
  public static User find(String email){ return email==null? null : USERS.get(email); }
}