package com.hwfs.ms.msc.dao;

import hone.core.util.record.RecordSet;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 위생점검결과조회 SaniCheckResultDetail DAO
 * 
 * @ClassName SaniCheckResultDetailDAO.java
 * @Description SaniCheckResultDetailDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/msc/saniCheckResultDetailDAO")
public class SaniCheckResultDetailDAO extends DefaultDAO {
	
	/**
	 * 위생점검결과 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msc.saniCheckResultDetailDAO.selectList", mapParam);
	}
	
}
