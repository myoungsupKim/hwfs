package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.cmn.dao.CustInchargeDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 거래처별 담당자를 관리하는 CustIncharge Service Implementation
 *
 * @ClassName CustInchargeServiceImpl.java
 * @Description CustInchargeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/custInchargeService")
public class CustInchargeServiceImpl extends DefaultServiceImpl implements CustInchargeService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CustInchargeDAO Bean 생성 */
	@Resource(name = "/sc/cmn/custInchargeDAO")
	private CustInchargeDAO custInchargeDAO;

	@Resource(name = "sccCustInchargeSeqGenSequence")
	private SequenceIdGenService sccCustInchargeSeqGenSequence;


	/**
	 * 거래처별 담당자 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return custInchargeDAO.selectList(mapParam);
	}

	/**
	 * 거래처별 담당자을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet select(Map<String, Object> mapParam) throws Exception {
		return custInchargeDAO.select(mapParam);
	}

	/**
	 * 거래처별 담당자 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//sccCustInchargeSeqGenSequence
				rowData.put("mgmtNum", BigDecimal.valueOf(Long.parseLong(sccCustInchargeSeqGenSequence.getNextStringId().trim())));
				insRowCnt += custInchargeDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += custInchargeDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += custInchargeDAO.delete(rowData);
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 신규 담당자를 생성한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.CustInchargeService#createIncharge(java.util.Map)
	*/
	@Override
	public int createIncharge(Map<String, Object> parameter) throws Exception {
		parameter.put("mgmtNum", BigDecimal.valueOf(Long.parseLong(sccCustInchargeSeqGenSequence.getNextStringId().trim())));

		return custInchargeDAO.insert(parameter);
	}

	/**
	 * modifyIncharge 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.CustInchargeService#modifyIncharge(java.util.Map)
	*/
	@Override
	public int modifyIncharge(Map<String, Object> parameter) throws Exception {
		return custInchargeDAO.update(parameter);
	}
}
