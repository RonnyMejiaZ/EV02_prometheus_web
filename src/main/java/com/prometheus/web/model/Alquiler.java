package com.prometheus.web.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Alquiler {
    private long id;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private int meses;                       // cantidad de meses
    private BigDecimal montoMensual;         // monto mensual
    private int personas;                    // número de personas
    private boolean activo;                  // estado del alquiler
    private String contrato;                 // código/identificador del contrato (o ruta/nota)
    private long inquilinoId;
    private long propiedadId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    public Alquiler() {}
    public Alquiler(long id,
                    LocalDate fechaInicio,
                    LocalDate fechaFin,
                    int meses,
                    BigDecimal montoMensual,
                    int personas,
                    boolean activo,
                    String contrato,
                    long inquilinoId,
                    long propiedadId,
                    LocalDateTime createdAt,
                    LocalDateTime updatedAt) {
        this.id = id;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.meses = meses;
        this.montoMensual = montoMensual;
        this.personas = personas;
        this.activo = activo;
        this.contrato = contrato;
        this.inquilinoId = inquilinoId;
        this.propiedadId = propiedadId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public LocalDate getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(LocalDate fechaInicio) { this.fechaInicio = fechaInicio; }

    public LocalDate getFechaFin() { return fechaFin; }
    public void setFechaFin(LocalDate fechaFin) { this.fechaFin = fechaFin; }

    public int getMeses() { return meses; }
    public void setMeses(int meses) { this.meses = meses; }

    public BigDecimal getMontoMensual() { return montoMensual; }
    public void setMontoMensual(BigDecimal montoMensual) { this.montoMensual = montoMensual; }

    public int getPersonas() { return personas; }
    public void setPersonas(int personas) { this.personas = personas; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }

    public String getContrato() { return contrato; }
    public void setContrato(String contrato) { this.contrato = contrato; }

    public long getInquilinoId() { return inquilinoId; }
    public void setInquilinoId(long inquilinoId) { this.inquilinoId = inquilinoId; }

    public long getPropiedadId() { return propiedadId; }
    public void setPropiedadId(long propiedadId) { this.propiedadId = propiedadId; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

}
