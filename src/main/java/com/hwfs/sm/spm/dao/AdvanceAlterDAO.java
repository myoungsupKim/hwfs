package com.hwfs.sm.spm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금대체를하는 AdvanceAlter DAO
 * 
 * @ClassName AdvanceAlterDAO.java
 * @Description AdvanceAlterDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.30   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.30
 * @version 1.0
 * @see 
 */
@Repository("/sm/spm/advanceAlterDAO")
public class AdvanceAlterDAO extends DefaultDAO {
	
	/**
	 * 선수금대체 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.spm.advanceAlterDAO.selectList", mapParam);
	}
}
