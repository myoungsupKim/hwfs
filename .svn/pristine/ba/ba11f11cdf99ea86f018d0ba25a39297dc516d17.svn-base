package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장기준정보 저장권한 관리 UpjangNonSaleDayDAO
 * 
 * @ClassName UpjangNonSaleDayDAO.java
 * @Description UpjangNonSaleDayDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2020.04.01   	이필승        최초생성
 * </pre>
 * @author 한화시스템/ICT : 이필승
 * @since 2020.04.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2019 by HANWHA CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/upjangNonSaleDayDAO")
public class UpjangNonSaleDayDAO extends DefaultDAO {
	
	/**
	 * 업장 매출 미등록 일자 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangNonSaleDayDAO.selectList", mapParam);
	}
	
	/**
	 * 업장 매출 미등록 일자 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListSalsDay(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangNonSaleDayDAO.selectListSalsDay", mapParam);
	}
	
	
	/**
	 * 업장 매출 미등록 일자 입력
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangNonSaleDay(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangNonSaleDayDAO.insertUpjangNonSaleDay", mapParam);
	}
	
	/**
	 * 업장 매출 미등록 일자 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangNonSaleDay(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangNonSaleDayDAO.updateUpjangNonSaleDay", mapParam);
	}
	
	/**
	 *  업장 매출 미등록 일자 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangNonSaleDay(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangNonSaleDayDAO.deleteUpjangNonSaleDay", mapParam);
	}
}