package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.AddressSampleDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주소정보 처리를 가이드하는 AddressSample Service Implementation
 *
 * @ClassName AddressSampleServiceImpl.java
 * @Description AddressSampleServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.10    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.10
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/addressSampleService")
public class AddressSampleServiceImpl extends DefaultServiceImpl implements AddressSampleService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AddressSampleDAO Bean 생성 */
	@Resource(name = "/guide/sample/addressSampleDAO")
	private AddressSampleDAO addressSampleDAO;


	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

//	@Resource(name = "/sc/cmn/slipNumService")
//	private SlipNumService slipNumService;

	/**
	 * 주소정보 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {

		//logger.debug("#######################################################################################");

		//for (int i=0 ; i < 1000 ; i++) {
		//	logger.debug("############# 전표번호 : [" + slipNumService.getSlipNumNewTx() + "] ###################");
		//}

		logger.debug("#######################################################################################");

		return addressSampleDAO.selectList(mapParam);
	}

	/**
	 * 주소정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, String sabun) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//주소 처리
			addressService.setAddress(rowData, "addrInfo", sabun);

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += addressSampleDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += addressSampleDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += addressSampleDAO.delete(rowData);
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}
}
