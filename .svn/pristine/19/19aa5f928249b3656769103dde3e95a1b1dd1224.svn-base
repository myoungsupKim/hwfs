package com.hwfs.ms.msc.dao;

import hone.core.util.record.RecordSet;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개선계획작성 SaniImprovePlanDAO 
 * 
 * @ClassName SaniImprovePlanDAO.java
 * @Description SaniImprovePlanDAO Class
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
@Repository("/ms/msc/saniImprovePlanDAO")
public class SaniImprovePlanDAO extends DefaultDAO {
	
	/**
	 * 개선계획작성 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaster(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msc.saniImprovePlanDAO.selectMaster", mapParam);
	}
	
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msc.saniImprovePlanDAO.selectDetail", mapParam);
	}
	
	public int updateList(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.msc.saniImprovePlanDAO.updateList", mapParam);
	}
	
}
