package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponDestributionCancelDAO;

 /**
 * 쿠폰 배포 취소 처리하는 CouponDestributionCancel Service Implementation
 * 
 * @ClassName CouponDestributionCancelServiceImpl.java
 * @Description CouponDestributionCancelServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.26    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponDestributionCancelService")
public class CouponDestributionCancelServiceImpl extends DefaultServiceImpl implements CouponDestributionCancelService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponDestributionCancelDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponDestributionCancelDAO")
	private CouponDestributionCancelDAO couponDestributionCancelDAO;
	

	/**
	 * 쿠폰 배포 취소 처리 목록을 조회한다.
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
		return couponDestributionCancelDAO.selectList(mapParam);
	}

	/**
	 * 쿠폰 배포 취소 처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list,DataSetMap inData) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		String maxCouponDplyNum = "";
		
		//쿠폰 배포 번호 MAX값 조회
		maxCouponDplyNum =  couponDestributionCancelDAO.selectMaxDplyNum(inData.get(0));
		
		//쿠폰 배포(이동) 마스터 처리
		
		Map<String, Object> rowAddData = inData.get(0);
		rowAddData.put("maxCouponDplyNum", maxCouponDplyNum);
		addRowCnt = couponDestributionCancelDAO.insertMst(rowAddData);

		for (int i = 0 ; i < list.size() ; i++) {
			
			//배포 상세 테이블 INSERT
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			rowData.put("maxCouponDplyNum", maxCouponDplyNum);
			rowData.put("quantity", "1");
			rowData.put("couponStatus", "1");
			rowData.put("dplyDate", inData.getMapValue(0, "moveDate"));
			rowData.put("recdStatus", "L");
			
			insRowCnt += couponDestributionCancelDAO.insertDetail(rowData);
			
			//쿠폰 번호 마스터에 업데이트 처리 한다.
			updRowCnt += couponDestributionCancelDAO.updateNumMst(rowData);

		}

		return insRowCnt + addRowCnt	 + updRowCnt;
	}
}
