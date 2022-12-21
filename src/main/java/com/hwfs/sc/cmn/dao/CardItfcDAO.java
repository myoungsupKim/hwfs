package com.hwfs.sc.cmn.dao;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import com.hwfs.sc.cmn.dto.CardApDataDTO;
import com.hwfs.sc.cmn.dto.CardHistDTO;
import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.dto.CardReplyDTO;

 /**
 * 신용카드 정보를 인터페이스 하는 DAO
 * 
 * @ClassName CardItfcDAO.java
 * @Description CardItfcDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.06   	ChAoS        최초생성
 * </pre>
 * @author 통합엽업회계(ISA) : ChAoS
 * @since 2015.07.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/cardItfcDAO")
public class CardItfcDAO extends DefaultDAO {
	
	/**
	 * 임시 테이블 생성 여부를 확인한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int isTempTableExist(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("sc.cmn.cardItfcDAO.isTempTableExist", mapParam);
	}
	
	/**
	 * 거래내역 임시 테이블을 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int apTempTableCreate(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.apTempTableCreate", mapParam);
	}

	/**
	 * 거래내역 임시 테이블을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int apTempTableDrop(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.apTempTableDrop", mapParam);
	}
	
	/**
	 * 거래내역 임시 테이블에 거래내역 내역을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int[] insertApTempData(List<CardApDataDTO> cardApDataList) throws Exception {
		
		String sql = getSql("sc.cmn.cardItfcDAO.insertApTempData");
		
		SqlParameterSource[] params = new SqlParameterSource[cardApDataList.size()];
	    for (int i = 0; i < cardApDataList.size(); i++) {
	        params[i] = new BeanPropertySqlParameterSource(cardApDataList.get(i));
	    }

	    return batchUpdate(sql, params);

	}
	
	/**
	 * 임시 테이블의 거래내역 데이터를 거래내역 테이블에 입력 / 수정 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int mergeApDataTemp(Map<String, Object> reply) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.mergeApDataTemp", reply);
	}
	
	/**
	 * 거래내역 임시 테이블의 거래내역을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteApTempData(Map<String, Object> reply) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.deleteApTempData", reply);		
	}
	
	/**
	 * 신용카드 거래내역 정보를 저장 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int[] insertCardApData(List<CardApDataDTO> cardApDataList) throws Exception {
		
		String sql = getSql("sc.cmn.cardItfcDAO.insertCardApData");
		
		SqlParameterSource[] params = new SqlParameterSource[cardApDataList.size()];
	    for (int i = 0; i < cardApDataList.size(); i++) {
	        params[i] = new BeanPropertySqlParameterSource(cardApDataList.get(i));
	    }

	    return batchUpdate(sql, params);

	}
	
	/**
	 * 신용카드 거래내역 정보를 수정 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateCardApData(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.updateCardApData", mapParam);
	}
	
	/**
	 * 입반송 임시 테이블을 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int replyTempTableCreate(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.replyTempTableCreate", mapParam);
	}

	/**
	 * 입반송 임시 테이블을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int replyTempTableDrop(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.replyTempTableDrop", mapParam);
	}
	
	/**
	 * 입반송 임시 테이블의 Key 값을 수정 한다. DDC(CAMIS) 전용
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateCardReplyTemp(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.updateCardReplyTemp", mapParam);
	}
	
	/**
	 * 임시 테이블의 입반송 데이터를 입반송 테이블에 입력 / 수정 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int mergeCardReplyTemp(Map<String, Object> reply) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.mergeCardReplyTemp", reply);
	}
	
	/**
	 * 입반송 임시 테이블의 입반송 내역을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteCardReplyTempData(Map<String, Object> reply) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.deleteCardReplyTempData", reply);		
	}
	
	/**
	 * 신용카드 VAN 사와 인터페이스 이력(청구, 거래내역, 입반송) 을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertCardHist(CardHistDTO cardHistDTO) throws Exception {
		return super.update("sc.cmn.cardItfcDAO.insertCardHist", cardHistDTO);
	}
	
	/**
	 * 신용카드 입반송 정보를 저장 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int[] insertCardReply(List<CardReplyDTO> cardReplyList) throws Exception {
		
		String sql = getSql("sc.cmn.cardItfcDAO.insertCardReply");
		
		SqlParameterSource[] params = new SqlParameterSource[cardReplyList.size()];
	    for (int i = 0; i < cardReplyList.size(); i++) {
	        params[i] = new BeanPropertySqlParameterSource(cardReplyList.get(i));
	    }

	    return batchUpdate(sql, params);

	}
	
	/**
	 * 입반송 임시 테이블에 입반송 내역을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int[] insertCardReplyTempData(List<CardReplyDTO> cardReplyList) throws Exception {
		
		String sql = getSql("sc.cmn.cardItfcDAO.insertCardReplyTempData");
		
		SqlParameterSource[] params = new SqlParameterSource[cardReplyList.size()];
	    for (int i = 0; i < cardReplyList.size(); i++) {
	        params[i] = new BeanPropertySqlParameterSource(cardReplyList.get(i));
	    }

	    return batchUpdate(sql, params);

	}	

}
