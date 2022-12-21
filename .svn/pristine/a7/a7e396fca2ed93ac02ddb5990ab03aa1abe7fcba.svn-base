package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.fs.fse.dao.EventMstRegDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dao.AttachFileDAO;
import com.hwfs.sc.cmn.util.FileUtil;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 이벤트 Master 등록관리하는 EventMstReg Service Implementation
 *
 * @ClassName EventMstRegServiceImpl.java
 * @Description EventMstRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.11
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventMstRegService")
public class EventMstRegServiceImpl extends DefaultServiceImpl implements EventMstRegService {

    /** EventMstRegDAO Bean 생성 */
    @Resource(name = "/fs/fse/eventMstRegDAO")
    private EventMstRegDAO eventMstRegDAO;

    /** AttachFileDAO */
    @Resource(name="/sc/cmn/attachFileDAO")
    private AttachFileDAO attachFileDAO;

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

    /** File Attach DB Sequence idGnrService */
    @Resource(name="idGenSequenceAtchFile")
    private SequenceIdGenService idGenSequenceAtchFile;    
    
    
    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectCboList(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectCboList(parameter);
    }

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectThemeList(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectThemeList(parameter);
    }

    /**
     * 이벤트 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectEventList(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectEventList(parameter);
    }

    /**
     * 이벤트 master 정보를 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectList(parameter);
    }
    
    /**
     * 진행절차 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectProgress(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectProgress(parameter);
    }

    /**
     * 기기/포장제 목록
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectUtensilList(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectUtensilList(parameter);
    }
    

    /**
     * 서버 사진을 조회한다.(첨부파일)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    @Override
    public RecordSet selectImgList(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectImgList(parameter);
    }
    
    
    /**
     * 이벤트 Master 등록관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param list
     * @param form
     * @param progress
     * @param utensil
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public int saveList(DataSetMap list, DataSetMap form, DataSetMap progress, DataSetMap utensil, DataSetMap file) throws Exception {
    	int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        
        String seq       = "";  //순번
        String strRefSeq = "";  //첨부참조일련번호

        //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
        if (file.size() > 0) {
            strRefSeq = save(file, propertiesService.getString("fs.file.path"), false);
        }
        
        
        //이벤트 목록 등록관리
        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if(rowData.get("lev").toString().equals("2")){              //2레벨
                if (rowType == DataSet.ROW_TYPE_INSERTED) {        //Insert 처리
                    insRowCnt += eventMstRegDAO.insertMclass(rowData);
                } else if (rowType == DataSet.ROW_TYPE_UPDATED) {  //Update 처리
                    updRowCnt += eventMstRegDAO.updateMclass(rowData);
                } else if (rowType == DataSet.ROW_TYPE_DELETED) {  //Delete 처리.
                    delRowCnt += eventMstRegDAO.deleteMclass(rowData);
                }

            } else if(rowData.get("lev").toString().equals("3")){       //3레벨
                if (rowType == DataSet.ROW_TYPE_INSERTED) {        //Insert 처리
                    insRowCnt += eventMstRegDAO.insertSclass(rowData);
                } else if (rowType == DataSet.ROW_TYPE_UPDATED) {  //Update 처리
                    updRowCnt += eventMstRegDAO.updateSclass(rowData);
                } else if (rowType == DataSet.ROW_TYPE_DELETED) {  //Delete 처리.
                    delRowCnt += eventMstRegDAO.deleteSclass(rowData);
                }
            }
        }

        //이벤트 등록 폼
        if (form.size() > 0) {
        	Map<String, Object> rowFormData = form.get(0);
            int rowFormType = ((Integer)rowFormData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            String signPrcgSabun = LimsUtil.checkNull(rowFormData.get("signPrcgSabun").toString());
            String signStatus    = LimsUtil.checkNull(rowFormData.get("signStatus").toString());

            if (!"".equals(strRefSeq)) {
                rowFormData.put("fileId", strRefSeq);
            }
            
            if (!"".equals(signPrcgSabun) && "".equals(signStatus)) {
                rowFormData.put("signStatus", "001");
            }

            if (rowFormType == DataSet.ROW_TYPE_INSERTED) {                          //Insert 처리
                RecordSet reMstSeq = eventMstRegDAO.selectMstSeq(rowFormData);

                seq = reMstSeq.get(0).getString("seq");
                rowFormData.put("seq", seq);
                insRowCnt += eventMstRegDAO.insertForm(rowFormData);
            } else if(rowFormType == DataSet.ROW_TYPE_UPDATED) {
                seq = rowFormData.get("seq").toString();

                if( LimsUtil.checkNull(rowFormData.get("useYn")).equals("N")) {     //Delete 처리.
                    delRowCnt += eventMstRegDAO.deleteForm(rowFormData);
                } else {                                                            //Update 처리
                    updRowCnt += eventMstRegDAO.updateForm(rowFormData);
                }
            } else {
                seq = rowFormData.get("seq").toString();

                if (!"".equals(strRefSeq)) {
                    updRowCnt += eventMstRegDAO.updateForm(rowFormData);
                }
            }
        }

        // 진행절차 삭제
        for (int i = 0 ; i < progress.size() ; i++) {
            Map<String, Object> rowProgressData = progress.get(i);
            int rowType = ((Integer)rowProgressData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_DELETED) {                              //Delete 처리.
                delRowCnt += eventMstRegDAO.deletePrcdr(rowProgressData);
            }
        }

        // 진행절차 등록
        for (int i = 0 ; i < progress.size() ; i++) {
            Map<String, Object> rowProgressData = progress.get(i);
            int rowType = ((Integer)rowProgressData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED) {                              //Update 처리
                updRowCnt += eventMstRegDAO.updatePrcdr(rowProgressData);
            } else if (rowType == DataSet.ROW_TYPE_INSERTED) {                      //Insert 처리
                rowProgressData.put("seq", seq);

                insRowCnt += eventMstRegDAO.insertPrcdr(rowProgressData);
            }
        }

        //기기/포장제 등록관리
        for (int i = 0 ; i < utensil.size() ; i++) {
            Map<String, Object> rowUtensilData = utensil.get(i);
            int rowType = ((Integer)rowUtensilData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_DELETED) {                                      //Delete 처리.
                delRowCnt += eventMstRegDAO.deleteUtensil(rowUtensilData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {                               //Update 처리
                updRowCnt += eventMstRegDAO.updateUtensil(rowUtensilData);
            } else if (rowType == DataSet.ROW_TYPE_INSERTED) {                              //Insert 처리
                RecordSet reUtensilId = eventMstRegDAO.selectUtensilId(rowUtensilData);

                String utensilId = reUtensilId.get(0).getString("utensilId");
                rowUtensilData.put("seq", seq);
                rowUtensilData.put("utensilId", utensilId);
                insRowCnt += eventMstRegDAO.insertUtensil(rowUtensilData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
    
    /**
     * 이벤트 Master 등록관리 DataSetMap의 데이터를 Delete 처리한다.
     *
     * @param list
     * @param form
     * @param progress
     * @param utensil
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public int deleteList(DataSetMap form) throws Exception {
    	int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        
        
        //이벤트 등록 폼
        if (form.size() > 0) {
        	Map<String, Object> rowFormData = form.get(0);
        	
        	//첨부파일 삭제하기 위해
        	rowFormData.put("refSeq", rowFormData.get("fileId"));
        	
        	//FSE_이벤트_원장 FSE_EVNT_MASTER 테이블 삭제
        	delRowCnt += eventMstRegDAO.deleteEventMst(rowFormData);
        	//FSE_이벤트_진행절차Master FSE_EVNT_PRCDR_MASTER 테이블 삭제
        	delRowCnt += eventMstRegDAO.deletePrcdrMst(rowFormData);
        	//FSE_이벤트_기기업체정보_master  FSE_EVNT_UTENSIL_MASTER  테이블 삭제
        	delRowCnt += eventMstRegDAO.deleteUtensilMst(rowFormData);
        	//첨부파일 SCC_APPEND_FILE 삭제
        	delRowCnt += attachFileDAO.delete(rowFormData);
        }

        return delRowCnt;
    }
    
    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 global.filerepository.path가 된다.
     * </pre>
     *
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미)
     * @throws Exception
     */
    public String save(DataSetMap listFile, String relPath, boolean encYn) throws Exception {
        return save(listFile, relPath, encYn, false, false);
    }

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다.
     * - useOrgnlNmYn가 true이면 원본 파일명을 유지
     * </pre>
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @param webRepoYn 파일저장소를 webapp 아래로 할지 여부(true이면 global.imagerepository.path 아래로 저장)
     * @param useOrgnlNmYn 파일저장 시 원본 파일명을 유지할지 여부 (보안에 문제가 없는 파일인 경우만 원본명 유지 가능)
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn) throws Exception {

        String strRefSeq = ""; //첨부일련번호

        //첨부일련번호를 얻는다.
        for (int i = 0; i < listFile.size(); i++) {
            Map<String, Object> map = listFile.get(i);
            int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType != DataSet.ROW_TYPE_INSERTED) { //ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_DELETED){
                strRefSeq =  map.get("refSeq").toString(); //Long.parseLong(map.get("refSeq").toString());
                break;
            }
        }
        //첨부일련번호를 새로 채번하는 경우 처리
        if (strRefSeq.equals(""))
            strRefSeq = idGenSequenceAtchFile.getNextStringId();

        int intCnt=0;   //파일 처리 건수

        //먼저 첨부파일 처리
        for (int i = 0; i < listFile.size(); i++) {
            Map<String, Object> map = listFile.get(i);

            int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if ( rowType == DataSet.ROW_TYPE_INSERTED ){
                //첨부일련번호 설정
                map.put("refSeq", strRefSeq);

                //저장시 원본파일명 유지 여부에 따라 처리
                if (!useOrgnlNmYn) {
                    //저장파일명 설정 - UUID 적용 및 시간표시
                    if (propertiesService.getBoolean("global.fileupload.appendTime"))
                        map.put("saveFileNm", idGenUUIdService.getNextStringHostId() + "-" + DateUtil.getYyyymmddhhmmss());
                    else
                        map.put("saveFileNm", idGenUUIdService.getNextStringHostId());
                }else{
                    map.put("saveFileNm", DateUtil.getYyyymmddhhmmss() + "-" + map.get("orgnlFileNm"));
                }
                //저장상대패스 설정
                map.put("relPath", relPath);

                //파일암호화 여부
                map.put("encYn", encYn ? "Y" : "N");

                //DAO 호출
                intCnt += attachFileDAO.insert(map);

                //파일저장소로 복사
                String sourceFile = propertiesService.getString("global.fileupload.path") + "/" + map.get("fileUploadNm");
                String targetFile;
                if (webRepoYn)
                    targetFile = propertiesService.getString("global.imagerepository.path") + relPath + "/" + map.get("saveFileNm");
                else
                    targetFile = propertiesService.getString("global.filerepository.path") + relPath + "/" + map.get("saveFileNm");

                //-파일암호화 처리
                if (encYn) {
                    String encFile = sourceFile + "_enc";
                    cryptoService.encryptFile(sourceFile, encFile);
                    sourceFile = encFile;
                }

                boolean isCopied = false;

                if (!"".equals(LimsUtil.checkNull(map.get("preView")))) {
                    String dirFrom = propertiesService.getString("global.imagerepository.path") + "/" + propertiesService.getString("ms.file.path");
                    String preView = LimsUtil.checkNull(map.get("preView").toString());
                    File   preFile = new File(dirFrom + preView);
                    
                    //파일 이동처리
                    FileUtils.copyFile(preFile, new File(targetFile));
                    if(preFile.isFile()) {
                        isCopied = true;
                    }
                } else {
                    //파일 이동처리
                    isCopied = FileUtil.copyFile (sourceFile, targetFile);
                }

                if (!isCopied)
                    throw super.processException("fail.uploadfile.not.found");

            } else if (rowType == DataSet.ROW_TYPE_UPDATED){
                intCnt += attachFileDAO.update(map);
            } else if (rowType == DataSet.ROW_TYPE_DELETED){
                intCnt += attachFileDAO.delete(map);
                //파일저장소 파일 삭제
                String targetFile;
                if (webRepoYn)
                    targetFile = propertiesService.getString("global.imagerepository.path") + map.get("relPath") + "/" + map.get("saveFileNm");
                else
                    targetFile = propertiesService.getString("global.filerepository.path") + map.get("relPath") + "/" + map.get("saveFileNm");
                FileUtil.deleteFile(targetFile);
            }
        }

        //새로 채번된 참조일련번호 (-1 이면 변경되지 않음을 의미)
        if (intCnt == 0)
            return "";
        else
            return strRefSeq;
    }
    
    /**
     * 이벤트 LV1 조회.(Tree) 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectLevel1(Map<String, Object> parameter) throws Exception {
        return eventMstRegDAO.selectLevel1(parameter);
    }
    
}
