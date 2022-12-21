package com.hwfs.fm.fmp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmp.dao.UpjangOpRateUpdateDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 운영율 업장별 업데이트하는 UpjangOpRateUpdate Service Implementation
 * 
 * @ClassName UpjangOpRateUpdateServiceImpl.java
 * @Description UpjangOpRateUpdateServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.06    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재영업 강대성
 * @since 2015.11.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmp/upjangOpRateUpdateService")
public class UpjangOpRateUpdateServiceImpl extends DefaultServiceImpl implements UpjangOpRateUpdateService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangOpRateUpdateDAO Bean 생성 */
	@Resource(name = "/fm/fmp/upjangOpRateUpdateDAO")
	private UpjangOpRateUpdateDAO upjangOpRateUpdateDAO;
	

	/**
	 * 운영율 업장별 업데이트 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return upjangOpRateUpdateDAO.selectList(parameter);
	}

	/**
	 * 운영율 업장별 업데이트 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> modifyList(DataSetMap saveList) throws Exception {
		int procCnt1 = 0;
		int procCnt2 = 0;
		int procCnt3 = 0;
		int procCnt4 = 0;
		
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "0";

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    
                	//운영율 업장별 업데이트(을)를 구매신청 테이블에 등록한다.
                	procCnt1 += upjangOpRateUpdateDAO.updateFcSoPr(parameter);
                    //운영율 업장별 업데이트(을)를 판매 단가_통합영업 테이블에 등록한다.
                    procCnt2 += upjangOpRateUpdateDAO.updateESPPODTSAL(parameter);
                    //운영율 업장별 업데이트(을)를 판매 단가 테이블에 등록한다.
                    procCnt3 += upjangOpRateUpdateDAO.updateESISALP(parameter);
                    
                    if(procCnt1 > 0 || procCnt2 > 0 || procCnt3 >0)
                    {
                    	
                    	//운영율 변경시 변경자, 변경시간 및 변경기간 데이터를 기록 및 수정한다.
                        procCnt4 += upjangOpRateUpdateDAO.updateOprateModifyHis(parameter);
                    
                    }
                    
                }
            }
        }
		
        int totalCnt = procCnt1 + procCnt2 + procCnt3 + procCnt4;
        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", totalCnt);

        return retVal;
	}
}
