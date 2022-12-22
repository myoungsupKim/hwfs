package com.hwfs.sc.scp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보 파기이력을 관리하는 PersDstryHist DAO
 * 
 * @ClassName PersDstryHistDAO.java
 * @Description PersDstryHistDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scp/persDstryHistDAO")
public class PersDstryHistDAO extends DefaultDAO {
	
	/**
	 * 개인정보 파기이력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scp.persDstryHistDAO.selectList", mapParam);
	}

	/**
	 * 개인정보 파기이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persDstryHistDAO.insert", mapParam);
	}
	
	/**
	 * 개인정보 파기이력(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persDstryHistDAO.update", mapParam);
	}
	
	/**
	 * 개인정보 파기이력(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persDstryHistDAO.delete", mapParam);
	}

	/**
	 * 사용자 지속이용 표명으로 인한 개인정보 파기통보 건을 취소처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelDstryNoti(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persDstryHistDAO.cancelDstryNoti", mapParam);
	}

}
