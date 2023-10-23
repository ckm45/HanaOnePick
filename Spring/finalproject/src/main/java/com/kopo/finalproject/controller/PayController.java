package com.kopo.finalproject.controller;

import com.kopo.finalproject.model.dto.BenefitDTO;
import com.kopo.finalproject.model.dto.MemberDTO;
import com.kopo.finalproject.model.dto.MyCardDTO;
import com.kopo.finalproject.model.dto.ProductDTO;
import com.kopo.finalproject.service.PayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
class PayController {

    @Autowired
    PayService payService;

    @RequestMapping("/")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index");
        return mav;
    }

    @GetMapping("/shop1")
    public String getShop1() {
        return "shop1";
    }

    @PostMapping("/shop1/detail")
    public ModelAndView product1Details(
            @RequestParam("productName") String productName,
            @RequestParam("price") String price) {
        ModelAndView mav = new ModelAndView("shop1-detail");

        mav.addObject("productName", productName);
        mav.addObject("price", price);
        return mav;
    }

    @GetMapping("/shop2")
    public String getShop2() {
        return "shop2";
    }

    @PostMapping("/shop2/detail")
    public ModelAndView product2Details(
            @RequestParam("productName") String productName,
            @RequestParam("price") String price) {
        ModelAndView mav = new ModelAndView("shop2-detail");

        mav.addObject("productName", productName);
        mav.addObject("price", price);
        return mav;
    }

    @GetMapping("/shop3")
    public String getShop3() {
        return "shop3";
    }

    @PostMapping("/shop3/detail")
    public ModelAndView product3Details(
            @RequestParam("productName") String productName,
            @RequestParam("price") String price, @RequestParam("productContent") String productContent, @RequestParam("product_calory") String product_calory, @RequestParam("product_natrium") String product_natrium, @RequestParam("product_sugar") String product_sugar, @RequestParam("product_protein") String product_protein, @RequestParam("product_caffeine") String product_caffeine,
            @RequestParam("product_saturatedFat") String product_saturatedFat) {
        ModelAndView mav = new ModelAndView("shop3-detail");
        System.out.println("productContent : " + productContent);
        System.out.println("price : " + price);
        System.out.println("product_calory : " + product_calory);
        System.out.println("product_natrium : " + product_natrium);
        System.out.println("product_sugar : " + product_sugar);
        System.out.println("product_protein : " + product_protein);
        System.out.println("product_caffeine : " + product_caffeine);
        System.out.println("product_saturatedFat : " + product_saturatedFat);

        mav.addObject("productName", productName);
        mav.addObject("price", price);
        mav.addObject("productContent", productContent);
        mav.addObject("product_calory", product_calory);
        mav.addObject("product_natrium", product_natrium);
        mav.addObject("product_sugar", product_sugar);
        mav.addObject("product_protein", product_protein);
        mav.addObject("product_caffeine", product_caffeine);
        mav.addObject("product_saturatedFat", product_saturatedFat);
        return mav;
    }

    //    @PostMapping("/payForm")
//    public ModelAndView getPayForm(@RequestParam("productName") String productName,
//                                   @RequestParam("productPrice") String price, @RequestParam("storeName") String storeName, @RequestParam("storeCategoryCode") String storeCategoryCode, HttpSession session) {
//        MemberDTO dto = (MemberDTO) session.getAttribute("dto");
//
//        String memberId = dto.getMemberId();
//        System.out.println("memberId : " + memberId);
//        System.out.println("productName : " + productName);
//        System.out.println("price : " + price);
//        System.out.println("storeName : " + storeName);
//        System.out.println("storeCategoryCode : " + storeCategoryCode);
//
//        List<MyCardDTO> myCardList = payService.getMyCardList(memberId);
//        for (MyCardDTO myCardDTO : myCardList) {
//            System.out.println(myCardDTO);
//        }
//        ModelAndView mav = new ModelAndView("payForm");
//        mav.addObject("productName", productName);
//        mav.addObject("price", price);
//        mav.addObject("storeName", storeName);
//        mav.addObject("storeCategoryCode", storeCategoryCode);
//        mav.addObject("myCardList", myCardList);
//        return mav;
//
//    }
    @GetMapping("/payForm")
    public ModelAndView getPayForm(HttpSession session) {
        MemberDTO dto = (MemberDTO) session.getAttribute("dto");
        List<ProductDTO> cartItems = (List<ProductDTO>) session.getAttribute("cartItems");
        String memberId = dto.getMemberId();
        for (ProductDTO cartItem : cartItems) {
            System.out.println(cartItem);
        }
        List<MyCardDTO> myCardList = payService.getMyCardList(memberId);
        for (MyCardDTO myCardDTO : myCardList) {
            System.out.println(myCardDTO);
        }
        ModelAndView mav = new ModelAndView("payForm");
        mav.addObject("storeCategoryCode", "CE");
        mav.addObject("storeName", "스타벅스 철산역점");
        mav.addObject("myCardList", myCardList);
        mav.addObject("cartItems", cartItems);
        return mav;

    }


    @PostMapping("/submitPayment")
    public ModelAndView submitPayment(@RequestParam("cardId") int cardId,
                                      @RequestParam("storeName") String storeName,
                                      @RequestParam("price") String price,
                                      @RequestParam("storeCategoryCode") String storeCategoryCode, HttpSession session) {
        ModelAndView mav = new ModelAndView("paymentSuccessPage");
        MemberDTO dto = (MemberDTO) session.getAttribute("dto");
        String memberId = dto.getMemberId();
        System.out.println("price : " + price);
        Map<Integer, BenefitDTO> resultMap = payService.submitPayment(cardId, memberId, storeName, price, storeCategoryCode);
        System.out.println("resultMap : " + resultMap);
        Integer benefitCount = null;
        BenefitDTO benefitDTO = null;

        for (Map.Entry<Integer, BenefitDTO> entry : resultMap.entrySet()) {
            benefitCount = entry.getKey();
            benefitDTO = entry.getValue();
        }
        mav.addObject("benefitCount", benefitCount);
        mav.addObject("benefitDTO", benefitDTO);
        mav.addObject("storeName", storeName);
        mav.addObject("price", price);
        return mav;
    }

//    @GetMapping("/getCartPage")
//    public String getCartPage() {
//        return "cart";
//    }

    @PostMapping("/addToCart")
    public String addToCart(@RequestParam String productName, @RequestParam int price, HttpSession session) {
        System.out.println("productName : " + productName);
        System.out.println("price : " + price);

        List<ProductDTO> cartItems = (List<ProductDTO>) session.getAttribute("cartItems");
        if (cartItems == null) {
            System.out.println("cartItems is null");
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }
        cartItems.add(new ProductDTO(productName, price));
        System.out.println("cartItems : " + cartItems);
        return "redirect:/shop3";
    }

    @GetMapping("/getCartPage")
    public ModelAndView viewCart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<ProductDTO> cartItems = (List<ProductDTO>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }
        ModelAndView modelAndView = new ModelAndView("cart");
        modelAndView.addObject("cartItems", cartItems);
        return modelAndView;
    }

    @PostMapping("/removeFromCart")
    @ResponseBody
    public Map<String, Boolean> removeFromCart(@RequestParam String productName, HttpSession session) {
        Map<String, Boolean> response = new HashMap<>();
        List<ProductDTO> cartItems = (List<ProductDTO>) session.getAttribute("cartItems");
        if (cartItems != null) {
            cartItems.removeIf(item -> item.getProductName().equals(productName));
            response.put("success", true);
        } else {
            response.put("success", false);
        }
        return response;
    }
}
