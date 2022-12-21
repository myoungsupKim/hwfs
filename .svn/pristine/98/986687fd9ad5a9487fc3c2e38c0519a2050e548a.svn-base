package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponDestributionDAO;

 /**
 * 쿠폰 배포 처리하는 CouponDestribution Service Implementation
 * 
 * @ClassName CouponDestributionServiceImpl.java
 * @Description CouponDestributionServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponDestributionService")
public class CouponDestributionServiceImpl extends DefaultServiceImpl implements CouponDestributionService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponDestributionDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponDestributionDAO")
	private CouponDestributionDAO couponDestributionDAO;
	

	/**
	 * 쿠폰 배포 처리 목록을 조회한다.
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
		return couponDestributionDAO.selectList(mapParam);
	}

	/**
	 * 쿠폰 배포 처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		maxCouponDplyNum =  couponDestributionDAO.selectMaxDplyNum(inData.get(0));
		
		//쿠폰 배포(이동) 마스터 처리
		
		Map<String, Object> rowAddData = inData.get(0);
		rowAddData.put("maxCouponDplyNum", maxCouponDplyNum);
		addRowCnt = couponDestributionDAO.insertMst(rowAddData);

		for (int i = 0 ; i < list.size() ; i++) {
			
			//배포 상세 테이블 INSERT
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if(!rowData.get("couponStatus").equals("2")){
				rowData.put("maxCouponDplyNum", maxCouponDplyNum);
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "2");
				rowData.put("dplyDate", inData.getMapValue(0, "moveDate"));
				rowData.put("recdStatus", "L");
				
				insRowCnt += couponDestributionDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponDestributionDAO.updateNumMst(rowData);
			}

		}

		return insRowCnt + addRowCnt	 + updRowCnt;
	}
}
