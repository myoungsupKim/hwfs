package com.hwfs.sc.app.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.hwfs.cmn.defaults.DefaultDAO;

public class DefaultfdappDAO extends DefaultDAO {

    /**
     * 식재모바일 데이터소스 지정
     */
	@Autowired @Qualifier("fdappDataSource")
	private DataSource dataSource;
	
	public void afterPropertiesSet() throws Exception {
	  	setDataSource(dataSource);
	  	super.afterPropertiesSet();
	}
}
