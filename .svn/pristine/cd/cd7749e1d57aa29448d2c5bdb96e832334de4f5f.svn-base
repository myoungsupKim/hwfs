package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채권마스터프로세스처리하는 ArMstProcess DAO
 * 
 * @ClassName ArMstProcessDAO.java
 * @Description ArMstProcessDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.10   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/arMstProcessDAO")
public class ArMstProcessDAO extends DefaultDAO {
	
	/**
	 * 채권마스터프로세스처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arMstProcessDAO.selectList", mapParam);
	}

	/**
	 * 채권마스터프로세스처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.insert", mapParam);
	}
	
	/**
	 * 채권마스터프로세스처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.update", mapParam);
	}
	
	/**
	 * 채권마스터프로세스처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.delete", mapParam);
	}
	
	/**
	 * 채권마스터프로세스처리(을)를 취소한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelArMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.cancelArMst", mapParam);
	}

	
	/**
	 * 채권마스터 생성번호를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectMaxArNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.sar.arMstProcessDAO.selectMaxArNum", mapParam, null);
	}

	/**
	 * 채권마스터프로세스에서 입금 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReceive(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.updateReceive", mapParam);
	}

	/**
	 * 채권 거래처/업장 이관 처리에서 신규로 이관된 채권을 수정 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateTrans(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.updateTrans", mapParam);
	}

	/**
	 * 채권 거래처/업장 이관 처리에서 신규로 이관된 채권을 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertTransSelect(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.insertTransSelect", mapParam);
	}

	/**
	 * 채권 거래처/업장 이관 처리에서 이관된 채권(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTrans(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.deleteTrans", mapParam);
	}
	
	/**
	 *  채권 거래처/업장 이관(을)를 취소 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancleTrans(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arMstProcessDAO.cancleTrans", mapParam);
	}
	

}
