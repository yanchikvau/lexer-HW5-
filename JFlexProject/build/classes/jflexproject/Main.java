/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jflexproject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

/**
 *
 * @author Админ
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        // TODO code application logic here
        // String path = "C:/Users/Админ/Documents/NetBeansProjects/JFlexProject/src/jflexproject/Lexer.flex";
       String path = "Lexer.flex";
       generarLexer(path);
        lexemWriter();
        
    }
    public static String getPath(){
        
        System.out.println("Введите путь, по которому расположен файл на языке L.");
        Scanner in = new Scanner(System.in);
        String s = in.nextLine();
      return s;  
    } 
   public static void generarLexer(String path){
        File file=new File(path);
        jflex.Main.generate(file);
        
    } 
   public static void lexemWriter() throws FileNotFoundException, IOException{
      
       
        
       String path = getPath();
        Reader reader = new BufferedReader(new FileReader(path));
        Lexer lexer = new Lexer (reader);
        String resultado="";
        while (true){
            String s=lexer.yylex();
            if(s==null){return;}
            else{System.out.print(s);}
            }
            
    
    } 
}
