package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /***
 * 매출등록 카피하는 UpjangSaleRegMgntCopy DAO
 * 
 * @ClassName UpjangSaleRegMgntCopyDAO.java
 * @Description UpjangSaleRegMgntCopyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.28   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통협영업 손형민
 * @since 2015.05.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/upjangSaleRegMgntCopyDAO")
public class UpjangSaleRegMgntCopyDAO extends DefaultDAO {
	
	/**
	 * 전일매출 복사 mst 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntCopyDAO.selectMst", mapParam);
	}
	/**
	 * 전일매출 복사 mst
	 *
	 * @param mapParam
	 * @return
	 */
	public int copyMst(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntCopyDAO.copyMst", mapParam);
	}
	/**
	 * 전일매출 복사 detail
	 *
	 * @param mapParam
	 * @return
	 */
	public int copyDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntCopyDAO.copyDetail", mapParam);
	}
	/**
	 * 전일매출 복사payment
	 *
	 * @param mapParam
	 * @return
	 */
	public int copyPayment(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntCopyDAO.copyPayment", mapParam);
	}
	/**
	 * 전일매출 복사 ReceiptNum 생성
	 *
	 * @param mapParam
	 * @return
	 */
	public String createReceiptNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangSaleRegMgntCopyDAO.createReceiptNum", mapParam, null);
	}
	
}
