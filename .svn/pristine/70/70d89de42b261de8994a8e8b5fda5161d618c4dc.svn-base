package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sm.saa.dao.AccdUpjangMngtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 사고업장관리하는 AccdUpjangMngt Service Implementation
 *
 * @ClassName AccdUpjangMngtServiceImpl.java
 * @Description AccdUpjangMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.22    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.22
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/saa/accdUpjangMngtService")
public class AccdUpjangMngtServiceImpl extends DefaultServiceImpl implements AccdUpjangMngtService {

    /** AccdUpjangMngtDAO Bean 생성 */
    @Resource(name = "/sm/saa/accdUpjangMngtDAO")
    private AccdUpjangMngtDAO accdUpjangMngtDAO;
    
  //주소를 처리하기 위한 공통 Service
  	@Resource(name = "/sc/cmn/addrSearchService")
  	private AddrSearchService addressService;

    /**
     * 사고업장관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return accdUpjangMngtDAO.selectList(parameter);
    }
    
    /**
    **
    * 사고채권발생보고, 매출 미발생 사유보고에 데이터가 있는지 확인한다.
    *
    * @param mapParam
    *            조회조건 Map
    * @return RecordSet
    *            조회결과
    * @throws Exception
    */
   public RecordSet selectAccdList(Map<String, Object> parameter) throws Exception {
	   return accdUpjangMngtDAO.selectAccdList(parameter);
   }

    /**
     * 사고업장관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public int saveList(DataSetMap list, LoginDTO loginDTO) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowlistData = list.get(i);
            int rowType = ((Integer)rowlistData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            
         // 주소 처리
         Map<String, Object> rtn = addressService.setAddress(rowlistData, "addrInfo", loginDTO.getSabun());
         
            if (rowType == DataSet.ROW_TYPE_DELETED) {                                      //Delete 처리.
                delRowCnt += accdUpjangMngtDAO.deleteAccdCustMst(rowlistData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {                               //Update 처리
                updRowCnt += accdUpjangMngtDAO.updateAccdCustMst(rowlistData);
            } else if (rowType == DataSet.ROW_TYPE_INSERTED) {                              //Insert 처리
                insRowCnt += accdUpjangMngtDAO.insertAccdCustMst(rowlistData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
