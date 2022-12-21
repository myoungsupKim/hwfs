package com.hwfs.rc.bms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * BuffetMgmtDAO에 대한 설명 작성
 * @ClassName BuffetMgmtDAO.java
 * @Description BuffetMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 3.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 8. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/buffetMgmtDAO")
public class BuffetMgmtDAO extends DefaultDAO {
	public RecordSet selectListCst(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.buffetMgmtDAO.selectListCst", parameter);
	}
	public RecordSet selectListCstDetail(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.buffetMgmtDAO.selectListCstDetail", parameter);
	}
	public int insertDataCst(Map<String, Object> parameter) {
		return super.update("rc.bms.buffetMgmtDAO.insertDataCst", parameter);
	}
	public int insertDataDetail(Map<String, Object> parameter) {
		return super.update("rc.bms.buffetMgmtDAO.insertDataDetail", parameter);
	}
	//마스터 (원가번호 생성 년월(6) 일련번호(4)
	public Record maxCodeCreateMst(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.buffetMgmtDAO.maxCodeCreateMst","");
	}
	
	//원가상세 일련번호 생성
	public Record maxCodeCreateDetail(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.buffetMgmtDAO.maxCodeCreateDetail",parameter);
	}
	
}
