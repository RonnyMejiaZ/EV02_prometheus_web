// com.prometheus.web.util.Pagination.java
package com.prometheus.web.util;

import jakarta.servlet.http.HttpServletRequest;
import com.prometheus.web.shared.PagedResult;

public class Pagination {
  public static final class Params {
    public final String q;
    public final int page;
    public final int size;

    public Params(String q, int page, int size) {
      this.q = q;
      this.page = page;
      this.size = size;
    }
  }

  public static Params readParams(HttpServletRequest req) {
    String q = trim(req.getParameter("q"));
    int page = parseInt(req.getParameter("page"), 0);
    int size = parseInt(req.getParameter("size"), 10);
    return new Params(q, page, size);
  }

  public static <T> void fill(HttpServletRequest req, Params p, PagedResult<T> pr) {
    req.setAttribute("items", pr.items);
    req.setAttribute("q", p.q == null ? "" : p.q);
    req.setAttribute("page", pr.page);
    req.setAttribute("pages", pr.totalPages());
    req.setAttribute("size", pr.size);
    req.setAttribute("total", pr.total);
  }

  private static String trim(String s) {
    return s == null ? null : s.trim();
  }

  private static int parseInt(String s, int def) {
    try {
      return Integer.parseInt(s);
    } catch (Exception e) {
      return def;
    }
  }
}