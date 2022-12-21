package com.hwfs.ma.mas.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ma.mas.dao.TicketTradeDAO;
import com.hwfs.sc.cmn.util.StringUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 식권교환하는 TicketTrade Service Implementation
 * 
 * @ClassName TicketTradeServiceImpl.java
 * @Description TicketTradeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.19    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.11.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ma/mas/ticketTradeService")
public class TicketTradeServiceImpl extends DefaultServiceImpl implements TicketTradeService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TicketTradeDAO Bean 생성 */
	@Resource(name = "/ma/mas/ticketTradeDAO")
	private TicketTradeDAO ticketTradeDAO;
	
	/**
	 * 식권교환 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		logger.debug("size : " + list.size());
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			logger.debug("rowData : " + rowData.toString());
			logger.debug("rowType : " + rowType);
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				int ticketQty = ticketTradeDAO.ticketQty(rowData);
				if(Integer.valueOf(rowData.get("E_QTY").toString()) > ticketQty){
					throw new BizException("교환가능 한 식권 수량이 부족 합니다.\n이미 식권이 판매 되었거나 재고가 변경되었습니다."); 
				}
				//교환대상 폐기처리
				int Group_seq = ticketTradeDAO.masTicketMstS(rowData);
				rowData.put("TICKET_GROUP", Group_seq);
				
				insRowCnt += ticketTradeDAO.insertS(rowData);
				//교환 하려는 식권 수량
				int ticketEqty = Integer.valueOf(rowData.get("E_QTY").toString());
				RecordSet ticketSeq = ticketTradeDAO.ticketSeq(rowData);
				for (int j = 0; j < ticketSeq.size(); j++) {
					Map<String, Object> etocletData = ticketSeq.get(j);
					logger.debug("EtocletData : " + etocletData.toString());
					int inqty = Integer.valueOf(etocletData.get("inQty").toString());
					logger.debug("등록가능한 식권 : " + inqty);
					//식권이 없으면 중지.
					if(ticketEqty == 0 || ticketEqty < 0){
						logger.debug("식권 수량 : " + ticketEqty + " 중지!!!!!!!!!!!!!");
						logger.debug("식권 수량 : " + ticketEqty + " 중지!!!!!!!!!!!!!");
						continue;
					}else{
						//교환대상 판매처리
						logger.debug("등록하려는 입고 식권 번호 : " + etocletData.get("ticketSeq"));
						logger.debug("등록하려는 입고 식권 번호 : " + etocletData.get("ticketSeq"));
						rowData.put("SOURCE_ID", etocletData.get("ticketSeq"));
						if(ticketEqty > inqty){
							rowData.put("ticketQty", inqty);
							logger.debug("등록가능 한 식권 : " + inqty);
						}else{ 
							rowData.put("ticketQty", ticketEqty);
						}
						logger.debug("등록가능 한 식권 : " + rowData.get("ticketQty"));
						logger.debug("등록가능 한 식권 : " + rowData.get("E_TICKET_ENDNUM"));
						
						logger.debug("");
						logger.debug("rowData : " + rowData.toString());
						logger.debug("");
						insRowCnt += ticketTradeDAO.insertE(rowData);
						int ticketInQty = Integer.valueOf(rowData.get("ticketQty").toString());
						int endNum = Integer.valueOf(rowData.get("E_TICKET_ENDNUM").toString());
						logger.debug("다음 등록할 식권 시작 번호 : " + (((endNum + 1) + ticketInQty) - 1));
						logger.debug("다음 등록할 식권 시작 번호 : " + (((endNum + 1) + ticketInQty) - 1));
						rowData.put("E_TICKET_ENDNUM",((endNum + 1) + ticketInQty) - 1);
						if(ticketEqty > inqty){
							ticketEqty -= inqty;
							logger.debug("등록하고 남은 식권 : " + ticketEqty);
							logger.debug("등록하고 남은 식권 : " + ticketEqty);
						}else{ 
							ticketEqty = 0;
						}
					}
					//교환 HIS
					insRowCnt += ticketTradeDAO.insertHis(rowData);
				}
			}else if (rowType == DataSet.ROW_TYPE_DELETED) {
				String delYn = ticketTradeDAO.delYn(rowData);
				if("Y".equals(delYn)){
					throw new BizException("이후 판매된 식권이 존재하여 삭제 할 수 없습니다.\nTO_자재명: "+rowData.get("E_ITEM_NM")+"\n교환일자: "+rowData.get("TRANS_DD"));
				}
				String receiptNum = ticketTradeDAO.selectReceiptNum(rowData);
				if(!"".equals(nvls(receiptNum))){
					throw new BizException("선수금이 등록되어 삭제 할 수 없습니다.\nTO_자재명: "+rowData.get("E_ITEM_NM")+"\n교환일자: "+rowData.get("TRANS_DD"));
				}
				
				updRowCnt += ticketTradeDAO.delete(rowData);
				
				delRowCnt += ticketTradeDAO.deleteChg(rowData);
			}			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	public String nvls(Object col) throws Exception{
		if(col == null)
			return "";
		else
			return StringUtil.null2string(col.toString(), "");
	}
}
