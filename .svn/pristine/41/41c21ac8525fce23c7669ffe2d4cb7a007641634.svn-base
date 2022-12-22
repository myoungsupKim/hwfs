package com.hwfs.sc.cmn.defaults;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 리조트 FO DB DAO 객체의 부모 클래스인 DefaultResortfoDAO
 * - DefaultDAO를 extend 하도록 되어 있으나 resortfoDataSource 데이터소스를 통해 DB에 접속하도록 지정한다.
 * 
 * @ClassName DefaultResortfoDAO.java
 * @Description DefaultResortfoDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 02.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DefaultResortfoDAO extends DefaultDAO {

    /**
     * 리조트 FO 데이터소스 지정
     */
	@Autowired @Qualifier("resortfoDataSource")
	private DataSource dataSource;
	
	public void afterPropertiesSet() throws Exception {
	  	setDataSource(dataSource);
	  	super.afterPropertiesSet();
	}
}
