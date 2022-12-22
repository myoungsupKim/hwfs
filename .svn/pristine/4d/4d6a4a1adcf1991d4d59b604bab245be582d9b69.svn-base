package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 장례식장 관리하는 FuneralDeadReg DAO
 * 
 * @ClassName FuneralDeadRegDAO.java
 * @Description FuneralDeadRegDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralDeadRegDAO")
public class FuneralDeadRegDAO extends DefaultDAO {
	
	/**
	 * 장례식장 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralDeadRegInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadRegDAO.selectFuneralDeadRegInfo", mapParam);
	}
	
	/**
	 * 장례식장 대기자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReservMaster(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadRegDAO.selectReservMaster", mapParam);
	}
	
	/**
	 * 대기자 리스트 순번 max+1을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaxNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadRegDAO.selectMaxNum", mapParam);
	}
	
	/**
	 * 호실변경 이력을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralParlorHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadRegDAO.selectFuneralParlorHistory", mapParam);
	}
	
	/**
	 * 호실 변경 팝업을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralRoomNumberChg(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadRegDAO.selectFuneralRoomNumberChg", mapParam);
	}
	
	/**
	 * 호실 변경 팝업 순번 max+1을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaxSeq(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadRegDAO.selectMaxSeq", mapParam);
	}

	/**
	 * 호실 변경 팝업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertFuneralRoomNumberChg(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadRegDAO.insertFuneralRoomNumberChg", mapParam);
	}
	
	/**
	 * 호실 변경 팝업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateFuneralRoomNumberChg(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadRegDAO.updateFuneralRoomNumberChg", mapParam);
	}
	
	/**
	 * 호실 변경 팝업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteFuneralRoomNumberChg(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadRegDAO.deleteFuneralRoomNumberChg", mapParam);
	}
	
	/**
	 * 고인 Master 호실을 수정한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateFuneralMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadRegDAO.updateFuneralMaster", mapParam);
	}
	
	/**
	 * 대기자리스트(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertReservMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadRegDAO.insertReservMaster", mapParam);
	}
	
	/**
	 * 대기자리스트(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReservMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadRegDAO.updateReservMaster", mapParam);
	}
	
	/**
	 * 대기자리스트(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteReservMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadRegDAO.deleteReservMaster", mapParam);
	}
}
