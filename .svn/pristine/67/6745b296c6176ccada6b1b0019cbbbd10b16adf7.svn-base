package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.rc.rcg.dao.DiscPromotionDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 할인 생성 관리하는 DiscPromotion Service Implementation
 * 
 * @ClassName DiscPromotionServiceImpl.java
 * @Description DiscPromotionServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.08.03    김명섭        최초생성
 * </pre>
 * @author FC정보기획팀 :  통합영업
 * @since 2018.08.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/discPromotionService")
public class DiscPromotionServiceImpl extends DefaultServiceImpl implements DiscPromotionService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** DiscPromotionDAO Bean 생성 */
	@Resource(name = "/rc/rcg/discPromotionDAO")
	private DiscPromotionDAO discPromotionDAO;
	

	/**
	 * 할인 생성 관리 목록을 조회한다.
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
		return discPromotionDAO.selectList(mapParam);
	}

	/**
	 * 할인 생성 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(DataSetMap list) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			System.out.println("rowType[" + rowType + "]");
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				System.out.println("discntNo[" + rowData.get("discntNo") + "]");
				System.out.println("startDate[" + rowData.get("startDate") + "]");
				System.out.println("useDept[" + rowData.get("useDept") + "]");
				System.out.println("useCust[" + rowData.get("useCust") + "]");
				System.out.println("useYn[" + rowData.get("useYn") + "]");
				insRowCnt += discPromotionDAO.insertRow(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += discPromotionDAO.update(rowData);
			}
		}
		rtn.put("cnt", insRowCnt + updRowCnt);
		return rtn;
	}

	/**
	 * 할인 생성 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int createProc(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int PubCnt = 0;
		String DiscNo = "";
		String StartDate = "";
		String useDept = "";
		String useCust = "";
		int Crtn;
		
		Map<String, Object> parameter = new HashMap<String, Object>();

		System.out.println(">>>>>>>>>>>>>>>>>createProc start<<<<<<<<<<<<<<<<<<<<<");
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//매수
			PubCnt = Integer.parseInt(rowData.get("publishCnt").toString());

			System.out.println("PubCnt:[" + PubCnt + "]");
			
			if (PubCnt > 0) {
				//할인권코드채번
				System.out.println(">>>>>>>>>>>>>>>>>selectDiscNo call<<<<<<<<<<<<<<<<<<<<<");
				DiscNo = discPromotionDAO.selectDiscNo(rowData);
				System.out.println("DiscNo:[" + DiscNo + "]");
				rowData.put("DiscNo", DiscNo);

				//할인권코드생성
				System.out.println(">>>>>>>>>>>>>>>>>CreateDiscNo call<<<<<<<<<<<<<<<<<<<<<");
				Crtn = discPromotionDAO.CreateDiscNo(rowData);
				System.out.println("Crtn:[" + Crtn + "]");
				
				StartDate = LimsUtil.checkNull(rowData.get("startDate"));
				useDept = LimsUtil.checkNull(rowData.get("useDept"));
				useCust = LimsUtil.checkNull(rowData.get("useCust"));

				System.out.println("StartDate:[" + StartDate + "]");
				System.out.println("useDept:[" + useDept + "]");
				System.out.println("useCust:[" + useCust + "]");
				
				for (int j = 1 ;  j <= PubCnt ; j++) {
					parameter.put("DiscNo", DiscNo);
					parameter.put("DiscNum", j);
					parameter.put("StartDate", StartDate);
					parameter.put("useDept", useDept);
					parameter.put("useCust", useCust);

					//할인마스터생성
					System.out.println(">>>>>>>>>>>>>>>>>insert call<<<<<<<<<<<<<<<<<<<<<");
					insRowCnt += discPromotionDAO.insert(parameter);				
				}
				
			}

		}
				
		return insRowCnt;
	}
	
}
