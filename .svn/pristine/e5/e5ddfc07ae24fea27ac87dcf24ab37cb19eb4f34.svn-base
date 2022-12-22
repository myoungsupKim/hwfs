package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.UpjangMealTicketMgntPopupDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 선수금 식권 관리조회하는 UpjangMealTicketMgntPopup Service Implementation
 * 
 * @ClassName UpjangMealTicketMgntPopupServiceImpl.java
 * @Description UpjangMealTicketMgntPopupServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.21    이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 이지운
 * @since 2015.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/upjangMealTicketMgntPopupService")
public class UpjangMealTicketMgntPopupServiceImpl extends DefaultServiceImpl implements UpjangMealTicketMgntPopupService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangMealTicketMgntPopupDAO Bean 생성 */
	@Resource(name = "/fs/fsl/upjangMealTicketMgntPopupDAO")
	private UpjangMealTicketMgntPopupDAO upjangMealTicketMgntPopupDAO;
	

	/**
	 * 선수금 식권 관리조회 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjangMealTicketMgntPopupList(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketMgntPopupDAO.selectUpjangMealTicketMgntPopupList(mapParam);
	}
	
	/**
	 * 선수금 식권 관리조회 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjangMealTicketDetail(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketMgntPopupDAO.selectUpjangMealTicketDetail(mapParam);
	}
	
	/**
	 * 선수금등록 매출 회수 내역
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjangMealSaleRcvyMgntPopupList(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketMgntPopupDAO.selectUpjangMealSaleRcvyMgntPopupList(mapParam);
	}
	
	/**
	 * 선수금등록 입금 처리 내역
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과 RECV_DLNG
	 * @throws Exception
	 */
	public RecordSet selectUpjangMealRecvDlngMgntPopupList(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketMgntPopupDAO.selectUpjangMealRecvDlngMgntPopupList(mapParam);
	}
	
}
