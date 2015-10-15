package com.ideacreator.login.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Implements Filter class
public class LoginFilter implements Filter {
	public void init(FilterConfig config) throws ServletException {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws java.io.IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession(false);
		if (session!=null && session.getAttribute("loggedInUser") != null) {
			String url = ((HttpServletRequest) request).getRequestURI().toString();
			String queryString = (((HttpServletRequest) request).getQueryString() == null
					|| ((HttpServletRequest) request).getQueryString().isEmpty()) ? ""
							: "?" + ((HttpServletRequest) request).getQueryString();
			chain.doFilter(request, response);
		} else {
			//session.invalidate();
			resp.sendRedirect("../");
		}
	}

	public void destroy() {
		/*
		 * Called before the Filter instance is removed from service by the web
		 * container
		 */
	}
}
