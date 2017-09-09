package com.chaoshi.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * ���ñ��������
 */
public class CharacterEncodingFilter implements Filter {

    protected FilterConfig filterConfig = null;
    protected String encoding = "";

    public void destroy() {
        filterConfig = null;
        encoding = null;
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain filterChain) throws IOException, ServletException {
        if (encoding != null) {
            //����request��response�ı�̸�ʽ��ע��������Ҫ�裬��û��response��
            //charset���������ҳ�����ʾ���롣
            request.setCharacterEncoding(this.encoding);
            response.setContentType("text/html;charset=utf-8");
        }
        //����ִ����һ��������
        filterChain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        this.encoding = filterConfig.getInitParameter("encoding");

    }
}