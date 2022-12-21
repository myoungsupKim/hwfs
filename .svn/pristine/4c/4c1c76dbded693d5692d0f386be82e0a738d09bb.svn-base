package com.hwfs.sc.cmn.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 피엔씨월드 순천만 외부POS매출 인터페이스용  DAO 개체
 * @ClassName ExternalUpjangIFDAO.java
 * @Description ExternalUpjangIFDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 5. 14.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018. 5. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/ExternalUpjangIFDAO")
public class ExternalUpjangIFDAO extends DefaultDAO {
	
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.ExternalUpjangIFDAO.insert", mapParam);
	}
	
	public int upjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("sc.cmn.ExternalUpjangIFDAO.upjang", mapParam);
	}
	
	public int dupcnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("sc.cmn.ExternalUpjangIFDAO.dupcnt", mapParam);
	}

}
