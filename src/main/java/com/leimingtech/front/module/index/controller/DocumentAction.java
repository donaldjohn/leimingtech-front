package com.leimingtech.front.module.index.controller;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author linjm
 * @Package com.leimingtech.front.module.DocumentAction
 * @Description:
 * @date 2015/12:08
 */
@Slf4j
@Controller
@RequestMapping("/document")
public class DocumentAction {

//    @Resource
//    private DocumentService documentService;


    @RequestMapping("/forward")
    public String forward(Model model,@RequestParam int id){
        //model.addAttribute("document",documentService.findById(id));
        model.addAttribute("docId",id);
        return "/help/doc";
    }

}
