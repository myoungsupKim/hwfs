package com.hwfs.sc.cmn.defaults;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 이연fnc DB DAO 객체의 부모 클래스인 DefaultYfnclDAO
 * - DefaultDAO를 extend 하도록 되어 있으나 yfncDataSource 데이터소스를 통해 DB에 접속하도록 지정한다.
 * 
 * @ClassName DefaultYfncDAO.java
 * @Description DefaultYfncDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 17.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DefaultYfncDAO extends DefaultDAO {

    /**
     * 이연fnc 데이터소스 지정
     */
	@Autowired @Qualifier("yfncDataSource")
	private DataSource dataSource;
	
	public void afterPropertiesSet() throws Exception {
	  	setDataSource(dataSource);
	  	super.afterPropertiesSet();
	}
}
