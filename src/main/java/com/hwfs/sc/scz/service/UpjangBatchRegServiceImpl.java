package com.hwfs.sc.scz.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.scz.dao.UpjangBatchRegDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장을 일괄등록하는 UpjangBatchReg Service Implementation
 *
 * @ClassName UpjangBatchRegServiceImpl.java
 * @Description UpjangBatchRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/upjangBatchRegService")
public class UpjangBatchRegServiceImpl extends DefaultServiceImpl implements UpjangBatchRegService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangBatchRegDAO Bean 생성 */
	@Resource(name = "/sc/scz/upjangBatchRegDAO")
	private UpjangBatchRegDAO upjangBatchRegDAO;

	@Resource(name="stUpjangSeqGenSequence")
	private SequenceIdGenService stUpjangSeqGenSequence;

	/**
	 * 업장 일괄등록 목록을 조회한다.
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
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDataValidation(DataSetMap list) throws Exception {
		List<Map<String, Object>> validData = new ArrayList<Map<String,Object>>();

		for (int i=0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			Map<String, Object> vData = new HashMap<String, Object>();

			RecordSet rsCust = upjangBatchRegDAO.selectCustDataValidation(rowData);

			if (rsCust == null || rsCust.size() == 0) {
				vData.put("custcd", "");
				vData.put("custnm", rowData.get("custnm"));
				vData.put("ceoNm", rowData.get("ceoNm"));
				vData.put("bsnNo", rowData.get("bsnNo"));
				vData.put("bizType", rowData.get("bizType"));
				vData.put("bizCat", rowData.get("bizCat"));
				vData.put("addr", rowData.get("addr"));
				vData.put("upjang", rowData.get("upjang"));
				vData.put("upjangnm", rowData.get("upjangnm"));
				vData.put("ccCd", rowData.get("ccCd"));

				if (rowData.containsKey("bankAcctNo")) {
					vData.put("bankAcctNo", rowData.get("bankAcctNo"));
				}
				else {
					vData.put("bankAcctNo", "");
				}

				vData.put("custInfo", "");

				vData.put("validCustProcCd", "F");
				vData.put("validCustProcNm", "신청필요");

				Map<String, Object> tmp = selectUpjangDataValidation(rowData);

				vData.put("validUpjangProcCd", tmp.get("validUpjangProcCd"));
				vData.put("validUpjangProcNm", tmp.get("validUpjangProcNm"));

				vData.put("requestSysId", "");
				vData.put("requestNum", "");
				vData.put("checkProcCd", "N");
				vData.put("saveComplate", "N");

			}
			else if (rsCust.size() == 1) {
				vData.put("custcd", rsCust.get(0).getString("custcd"));
				vData.put("custnm", rsCust.get(0).getString("custnm"));
				vData.put("ceoNm", rsCust.get(0).getString("drname1"));
				vData.put("bsnNo", rowData.get("bsnNo"));
				vData.put("bizType", rsCust.get(0).getString("upTae"));
				vData.put("bizCat", rsCust.get(0).getString("upJong"));
				vData.put("addr", rowData.get("addr"));
				vData.put("upjang", rowData.get("upjang"));
				vData.put("upjangnm", rowData.get("upjangnm"));
				vData.put("ccCd", rowData.get("ccCd"));
				vData.put("saveComplate", "N");

				if (rowData.containsKey("bankAcctNo")) {
					vData.put("bankAcctNo", rowData.get("bankAcctNo"));
				}
				else {
					vData.put("bankAcctNo", "");
				}
				vData.put("custInfo", "");

				vData.put("validCustProcCd", "S");
				vData.put("validCustProcNm", "성공");

				Map<String, Object> tmp = selectUpjangDataValidation(rowData);

				vData.put("validUpjangProcCd", tmp.get("validUpjangProcCd"));
				vData.put("validUpjangProcNm", tmp.get("validUpjangProcNm"));

				vData.put("requestSysId", "");
				vData.put("requestNum", "");
				vData.put("checkProcCd", "Y");
			}
			else if (rsCust.size() > 1) {
				vData.put("custcd", "");
				vData.put("custnm", rowData.get("custnm"));
				vData.put("ceoNm", rowData.get("ceoNm"));
				vData.put("bsnNo", rowData.get("bsnNo"));
				vData.put("bizType", rowData.get("bizType"));
				vData.put("bizCat", rowData.get("bizCat"));
				vData.put("addr", rowData.get("addr"));
				vData.put("upjang", rowData.get("upjang"));
				vData.put("upjangnm", rowData.get("upjangnm"));
				vData.put("ccCd", rowData.get("ccCd"));
				vData.put("saveComplate", "N");

				if (rowData.containsKey("bankAcctNo")) {
					vData.put("bankAcctNo", rowData.get("bankAcctNo"));
				}
				else {
					vData.put("bankAcctNo", "");
				}

				StringBuffer sbCust = new StringBuffer();
				sbCust.append("[");
				for (int j = 0 ; j < rsCust.size() ; j++) {
					Record rCust = rsCust.get(j);

					if (j > 0) {
						sbCust.append(",");
					}

					sbCust.append("{");
					sbCust.append(" \"custcd\":\"");		sbCust.append(rCust.getString("custcd"));		sbCust.append("\"");
					sbCust.append(",\"custnm\":\"");		sbCust.append(rCust.getString("custnm"));		sbCust.append("\"");
					sbCust.append(",\"custgubun\":\"");		sbCust.append(rCust.getString("custgubun"));	sbCust.append("\"");
					sbCust.append(",\"custtype\":\"");		sbCust.append(rCust.getString("custtype"));		sbCust.append("\"");
					sbCust.append(",\"drname1\":\"");		sbCust.append(rCust.getString("drname1"));		sbCust.append("\"");
					sbCust.append(",\"upJong\":\"");		sbCust.append(rCust.getString("upJong"));		sbCust.append("\"");
					sbCust.append(",\"upTae\":\"");			sbCust.append(rCust.getString("upTae"));		sbCust.append("\"");
					sbCust.append("}");
				}
				sbCust.append("]");

				vData.put("custInfo", sbCust.toString());
				vData.put("validCustProcCd", "C");
				vData.put("validCustProcNm", "선택필요");

				Map<String, Object> tmp = selectUpjangDataValidation(rowData);

				vData.put("validUpjangProcCd", tmp.get("validUpjangProcCd"));
				vData.put("validUpjangProcNm", tmp.get("validUpjangProcNm"));

				vData.put("requestSysId", "");
				vData.put("requestNum", "");
				vData.put("checkProcCd", "N");
			}

			validData.add(vData);
		}

		return validData;
	}

	/**
	 * 업장 일괄등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> saveList(DataSetMap list, Map<String, Object> inVar) throws Exception {
		List<Map<String, Object>> listData = new ArrayList<Map<String,Object>>();

		String upjang = "";

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			Map<String, Object> data = new HashMap<String, Object>();

			if (rowData.containsKey("upjang") && "".equals(rowData.get("upjang").toString()) && "Y".equals(rowData.get("checkProcCd").toString())) {

				upjang = stUpjangSeqGenSequence.getNextStringId().trim();

				logger.info("---------------------------------------------------------------------");
				logger.info("업장 정보를 생성한다.(" + upjang + ")");
				logger.info("---------------------------------------------------------------------");

				rowData.put("upjang", upjang);
				rowData.put("ccCd", inVar.get("ccCd"));
				rowData.put("validCustProcCd", "S");
				rowData.put("validCustProcNm", "");

				rowData.put("validUpjangProcCd", "S");
				rowData.put("validUpjangProcNm", "신규 업장("+upjang+")으로 생성함.");

				rowData.put("checkProcCd", "");

				upjangBatchRegDAO.insert(rowData);
				upjangBatchRegDAO.insertStUpjang(rowData);
				upjangBatchRegDAO.insertSccAddrInfo(rowData);
				//upjangBatchRegDAO.insertScoUpjangMst(rowData);
				//upjangBatchRegDAO.insertFmsUpjang(rowData);
			}

			data.put("custnm", rowData.get("custnm"));
			data.put("ceoNm", rowData.get("ceoNm"));
			data.put("bsnNo", rowData.get("bsnNo"));
			data.put("bizType", rowData.get("bizType"));
			data.put("bizCat", rowData.get("bizCat"));
			data.put("addr", rowData.get("addr"));
			data.put("upjangnm", rowData.get("upjangnm"));
			data.put("bankAcctNo", rowData.get("bankAcctNo"));
			data.put("validCustProcCd", "S");
			data.put("validCustProcNm", "");
			data.put("custcd", rowData.get("custcd"));
			data.put("custInfo", rowData.get("custInfo"));
			data.put("validUpjangProcCd", rowData.get("validUpjangProcCd"));
			data.put("validUpjangProcNm", rowData.get("validUpjangProcNm"));
			data.put("requestSysId", rowData.get("requestSysId"));
			data.put("requestNum", rowData.get("requestNum"));
			data.put("checkProcCd", rowData.get("checkProcCd"));
			data.put("saveComplate", "S");

			listData.add(data);
		}

		return listData;
	}


	private Map<String, Object> selectUpjangDataValidation(Map<String, Object> parameter) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();

		RecordSet rs = upjangBatchRegDAO.selectUpjangDataValidation(parameter);

		if (rs == null || rs.size() == 0) {
			rtn.put("validUpjangProcCd", "N");
			rtn.put("validUpjangProcNm", "");
		}
		else if (rs.size() == 1) {
			rtn.put("validUpjangProcCd", "S");
			rtn.put("validUpjangProcNm", "등록업장(" + rs.get(0).getString("upjangnm") + "(" + rs.get(0).getString("upjang") + "))");
		}
		else if (rs.size() > 1) {
			StringBuffer sb = new StringBuffer();
			sb.append("등록업장(");

			for (int i = 0 ; i < rs.size() ; i++) {
				if (i > 0) {
					sb.append(",");
				}

				sb.append(rs.get(i).getString("upjangnm"));
				sb.append("(");
				sb.append(rs.get(i).getString("upjang"));
				sb.append(")");
			}
			sb.append(")");

			rtn.put("validUpjangProcCd", "M");
			rtn.put("validUpjangProcNm", sb.toString());
		}

		return rtn;
	}
}
