package com.prometheus.web.model;
public class User {
  private long userId;
  private String name;
  private String email;
  private String password;
  public User(long userId, String name, String email, String password) {
    this.userId = userId;
    this.name = name;
    this.email = email;
    this.password = password;
  }
  public long getUserId(){ return userId; }
  public String getName(){ return name; }
  public String getEmail(){ return email; }
  public String getPassword(){ return password; }
}