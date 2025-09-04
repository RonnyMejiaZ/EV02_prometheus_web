package com.prometheus.web.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Pago {
    private long id;
    private long alquilerId;

    private LocalDate fechaPago;
    private BigDecimal montoMensual;

    private boolean alquilerPago;

    private String compAlquiler;

    private String reciboAgua;
    private String compAgua;

    private String reciboEnergia;
    private String compEnergia;

    private String reciboGas;
    private String compGas;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Pago() {
    }

    public Pago(long id,
            long alquilerId,
            LocalDate fechaPago,
            BigDecimal montoMensual,
            boolean alquilerPago,
            String compAlquiler,
            String reciboAgua, String compAgua,
            String reciboEnergia, String compEnergia,
            String reciboGas, String compGas,
            LocalDateTime createdAt,
            LocalDateTime updatedAt) {
        this.id = id;
        this.alquilerId = alquilerId;
        this.fechaPago = fechaPago;
        this.montoMensual = montoMensual;
        this.alquilerPago = alquilerPago;
        this.compAlquiler = compAlquiler;
        this.reciboAgua = reciboAgua;
        this.compAgua = compAgua;
        this.reciboEnergia = reciboEnergia;
        this.compEnergia = compEnergia;
        this.reciboGas = reciboGas;
        this.compGas = compGas;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters & Setters

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getAlquilerId() {
        return alquilerId;
    }

    public void setAlquilerId(long alquilerId) {
        this.alquilerId = alquilerId;
    }

    public LocalDate getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(LocalDate fechaPago) {
        this.fechaPago = fechaPago;
    }

    public BigDecimal getMontoMensual() {
        return montoMensual;
    }

    public void setMontoMensual(BigDecimal montoMensual) {
        this.montoMensual = montoMensual;
    }

    public boolean isAlquilerPago() {
        return alquilerPago;
    }

    public void setAlquilerPago(boolean alquilerPago) {
        this.alquilerPago = alquilerPago;
    }

    public String getCompAlquiler() {
        return compAlquiler;
    }

    public void setCompAlquiler(String compAlquiler) {
        this.compAlquiler = compAlquiler;
    }

    public String getReciboAgua() {
        return reciboAgua;
    }

    public void setReciboAgua(String reciboAgua) {
        this.reciboAgua = reciboAgua;
    }

    public String getCompAgua() {
        return compAgua;
    }

    public void setCompAgua(String compAgua) {
        this.compAgua = compAgua;
    }

    public String getReciboEnergia() {
        return reciboEnergia;
    }

    public void setReciboEnergia(String reciboEnergia) {
        this.reciboEnergia = reciboEnergia;
    }

    public String getCompEnergia() {
        return compEnergia;
    }

    public void setCompEnergia(String compEnergia) {
        this.compEnergia = compEnergia;
    }

    public String getReciboGas() {
        return reciboGas;
    }

    public void setReciboGas(String reciboGas) {
        this.reciboGas = reciboGas;
    }

    public String getCompGas() {
        return compGas;
    }

    public void setCompGas(String compGas) {
        this.compGas = compGas;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
