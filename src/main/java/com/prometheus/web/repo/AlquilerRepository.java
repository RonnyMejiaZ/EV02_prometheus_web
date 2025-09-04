package com.prometheus.web.repo;

import com.prometheus.web.model.Alquiler;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;
import com.prometheus.web.shared.PagedResult;

public class AlquilerRepository {
    private static final Map<Long, Alquiler> DATA = new LinkedHashMap<>();
    private static final AtomicLong SEQ = new AtomicLong(1);

    public static synchronized List<Alquiler> findAll() {
        return new ArrayList<>(DATA.values()); // copia defensiva
    }

    public static synchronized Alquiler save(Alquiler p) {
        LocalDateTime now = LocalDateTime.now();
        if (p.getId() == 0) {
            p.setId(SEQ.getAndIncrement());
            p.setCreatedAt(now);
        }
        p.setUpdatedAt(now);
        DATA.put(p.getId(), p);
        return p;
    }

    public static synchronized boolean deleteById(long id) {
        return DATA.remove(id) != null;
    }

    // ----- BÚSQUEDA -----
    public static synchronized List<Alquiler> search(String q) {
        if (q == null || q.isBlank())
            return findAll();
        String term = q.toLowerCase(Locale.ROOT).trim();
        return DATA.values().stream()
                .filter(p -> contains(String.valueOf(p.getId()), term))
                .collect(Collectors.toList());
    }

    private static boolean contains(String s, String term) {
        return s != null && s.toLowerCase(Locale.ROOT).contains(term);
    }

    // ----- Paginación -----
    public static PagedResult<Alquiler> searchPage(String q, int page, int size) {
        List<Alquiler> all = search(q);
        int from = Math.max(0, Math.min(page * size, all.size()));
        int to = Math.min(from + size, all.size());
        List<Alquiler> slice = all.subList(from, to);
        return new PagedResult<>(slice, all.size(), page, size);
    }

    public static synchronized Alquiler update(Alquiler p) {
        p.setUpdatedAt(LocalDateTime.now());
        DATA.put(p.getId(), p);
        return p;
    }

    public static synchronized Alquiler findById(long id) {
        return DATA.get(id);
    }
}
