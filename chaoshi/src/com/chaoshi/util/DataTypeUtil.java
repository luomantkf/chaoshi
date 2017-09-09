package com.chaoshi.util;

import java.text.DecimalFormat;

/**
 * Created by Administrator on 2017/2/3.
 */
public class DataTypeUtil {
    public static double formatDouble(double d){
        DecimalFormat df = new DecimalFormat( "0.00");
        return Double.parseDouble(df.format(d));
    }

    /**
     * 冒泡排序：从大到小
     * @param arr
     */
    public static void bubbleSort(int[] arr){
        int temp;
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr.length - 1; j++) {
                if (arr[i] > arr[j]) {
                    temp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = temp;
                }
            }

        }
    }
}
