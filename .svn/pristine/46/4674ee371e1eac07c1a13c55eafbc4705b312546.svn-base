package com.hwfs.sc.cmn.defaults;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.hwfs.cmn.defaults.DefaultDAO;


public class DefaultSISDAO extends DefaultDAO {

    @Autowired @Qualifier("sisDataSource")
	private DataSource dataSource;
	
	public void afterPropertiesSet() throws Exception {
	  	setDataSource(dataSource);
	  	super.afterPropertiesSet();
	}
}
