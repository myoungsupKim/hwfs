package com.hwfs.ft.ftp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.ftp.dao.PoOrderOtherAmtDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 구매주문 부대비하는 PoOrderOtherAmt Service Implementation
 *
 * @ClassName PoOrderOtherAmtServiceImpl.java
 * @Description PoOrderOtherAmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20    KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.03.20
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/ftp/poOrderOtherAmtService")
public class PoOrderOtherAmtServiceImpl extends DefaultServiceImpl implements PoOrderOtherAmtService {

    /** PoOrderOtherAmtDAO Bean 생성 */
    @Resource(name = "/ft/ftp/poOrderOtherAmtDAO")
    private PoOrderOtherAmtDAO poOrderOtherAmtDAO;


    /**
     * 구매주문 부대비 관리 목록을 조회한다.
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
        return poOrderOtherAmtDAO.selectList(mapParam);
    }

    /**
     * 구매주문 부대비 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveList(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += poOrderOtherAmtDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += poOrderOtherAmtDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += poOrderOtherAmtDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
