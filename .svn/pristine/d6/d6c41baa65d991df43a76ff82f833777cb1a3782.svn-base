package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.TransactionSpecificationDAO;
import com.hwfs.fm.fms.dao.UpriceContractUpjangSetDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

/**
* 거래명세서(브랜드) TransactionSpecificationService Implementation
* 
* @ClassName TransactionSpecificationServiceImpl.java
* @Description TransactionSpecificationServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.08.25   	윤인묵        최초생성
* </pre> 
* @author 윤인묵
* @since 2021.08.25
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/fm/fms/transactionSpecificationService")
public class TransactionSpecificationServiceImpl extends DefaultServiceImpl implements TransactionSpecificationService {
	
	/** UpriceContractUpjangSetDAO Bean 생성 */
	@Resource(name = "/fm/fms/transactionSpecificationDAO")
	private TransactionSpecificationDAO transactionSpecificationDAO;
	
	/**
	 *거래명세서 DATA를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return transactionSpecificationDAO.selectList(mapParam);
	}
	
	/**
	 * 거래명세서 파라미터 저장
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveParamList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int insRowCnt = 0;
		int delCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			
			//Update 처리
			if (isCheck) {
				if(delCnt == 0){
					transactionSpecificationDAO.deleteParamList(rowData);
					delCnt++;
				}
				insRowCnt += transactionSpecificationDAO.insertParamList(rowData);
			}
		}
		
		return insRowCnt;
	}
}
