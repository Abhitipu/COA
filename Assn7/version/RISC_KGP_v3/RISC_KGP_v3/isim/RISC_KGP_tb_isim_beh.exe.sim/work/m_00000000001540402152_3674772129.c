/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Abhinandan/Desktop/Kgp/Class/3rd yr/5th sem/COA Lab/Github/COA/Assn7/version/RISC_KGP_v3/RISC_KGP_v3/RegisterFile.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};



static void Always_29_0(char *t0)
{
    char t11[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    int t18;

LAB0:    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(29, ng0);
    t2 = (t0 + 4128);
    *((int *)t2) = 1;
    t3 = (t0 + 3840);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(29, ng0);

LAB5:    xsi_set_current_line(30, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 2888);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 32);
    xsi_set_current_line(31, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:
LAB8:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 2168U);
    t3 = *((char **)t2);
    t2 = (t0 + 2128U);
    t4 = (t2 + 72U);
    t5 = *((char **)t4);
    t12 = (t0 + 2128U);
    t13 = (t12 + 48U);
    t14 = *((char **)t13);
    t15 = (t0 + 1528U);
    t16 = *((char **)t15);
    xsi_vlog_generic_get_array_select_value(t11, 32, t3, t5, t14, 2, 1, t16, 5, 2);
    t15 = (t0 + 2568);
    xsi_vlogvar_assign_value(t15, t11, 0, 0, 32);
    xsi_set_current_line(35, ng0);
    t2 = (t0 + 2168U);
    t3 = *((char **)t2);
    t2 = (t0 + 2128U);
    t4 = (t2 + 72U);
    t5 = *((char **)t4);
    t12 = (t0 + 2128U);
    t13 = (t12 + 48U);
    t14 = *((char **)t13);
    t15 = (t0 + 1688U);
    t16 = *((char **)t15);
    xsi_vlog_generic_get_array_select_value(t11, 32, t3, t5, t14, 2, 1, t16, 5, 2);
    t15 = (t0 + 2728);
    xsi_vlogvar_assign_value(t15, t11, 0, 0, 32);
    goto LAB2;

LAB6:    xsi_set_current_line(31, ng0);

LAB9:    xsi_set_current_line(32, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t0 + 2888);
    t12 = (t0 + 2888);
    t13 = (t12 + 72U);
    t14 = *((char **)t13);
    t15 = (t0 + 1848U);
    t16 = *((char **)t15);
    xsi_vlog_generic_convert_bit_index(t11, t14, 2, t16, 5, 2);
    t15 = (t11 + 4);
    t17 = *((unsigned int *)t15);
    t18 = (!(t17));
    if (t18 == 1)
        goto LAB10;

LAB11:    goto LAB8;

LAB10:    xsi_vlogvar_assign_value(t5, t4, 0, *((unsigned int *)t11), 1);
    goto LAB11;

}


extern void work_m_00000000001540402152_3674772129_init()
{
	static char *pe[] = {(void *)Always_29_0};
	xsi_register_didat("work_m_00000000001540402152_3674772129", "isim/RISC_KGP_tb_isim_beh.exe.sim/work/m_00000000001540402152_3674772129.didat");
	xsi_register_executes(pe);
}
