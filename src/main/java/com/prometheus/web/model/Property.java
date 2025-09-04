package com.prometheus.web.model;

import java.time.LocalDateTime;

public class Property {
    private long id;
    private String nombre;
    private String direccion;
    private String descripcion;
    private boolean rentado;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Property() {}
    public Property(long id, String nombre, String direccion, String descripcion, boolean rentado, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.nombre = nombre;
        this.direccion = direccion;
        this.descripcion = descripcion;
        this.rentado = rentado;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public boolean isRentado() { return rentado; }
    public void setRentado(boolean rentado) { this.rentado = rentado; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
