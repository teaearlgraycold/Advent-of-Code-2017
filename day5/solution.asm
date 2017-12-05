.text
.globl main

main:
# void main() {
    # int[] table = {0, 0, 2, 0, 0, ...};
    la  $a0,table    # Get table pointer
    ori $a1,$0,1032  # Table size
    # int num_jumps = solve(&table, 1032);
    jal solve
    # printf("%d\n", num_jumps);
    ori $a0,$s0,0    # Copy return value to SYSCALL argument
    ori $v0,$0,0x1   # set SYSCALL to 1 (display int)
    syscall
# }
    jr $ra

# Part 1
# a0 - table start
# a1 - table size
# t0 - table pointer
# t1 - next table offset
# t2 - jump counter
# t3 - temp
# t4 - table end
# t5 - temp
# t6 - temp
# s0 - return value (number of jumps)
solve:
# int solve(int* table, int size) {
    # int* table_ptr = table;
    ori  $t0,$a0,0   # Copy table start to table pointer
    # int* end = table_ptr + size * sizeof(int);
    sll  $a1,$a1,2   # Multiply size by 4 (to convert it to words)
    add  $t4,$t0,$a1 # Calculate table end
    # int counter = 0;
    ori  $t2,$0,0    # Initialize counter at 0
    # int offset;
loop:
    # while (true) {
        # offset = table[*table_ptr];
    lw   $t1,0($t0)  # Copy data at pointer
        # int* temp = table_ptr + offset * sizeof(int);
    sll  $t6,$t1,2   # Multiply offset by 4 (to convert it to words)
    add  $t3,$t0,$t6 # Add offset to table_ptr
        # table[*table_ptr]++;
    addi $t1,$t1,1   # Increment jump by one word
    sw   $t1,0($t0)  # Store incremented jump
        # table_ptr = temp;
    ori  $t0,$t3,0   # Update table pointer

        # counter++;
        # if (table_ptr < table)
            # break;
        # if (table_ptr > (table + size))
            # break;
    addi $t2,$t2,1   # Increment jump count
    sub  $t3,$t0,$a0 # The offset from the start
    sub  $t5,$t0,$t4 # The offset from the end

    bltz $t3,return  # Return if we've jumped before the array start
    bgtz $t5,return  # Return if we've jumped past the array end
    # }
    j    loop        # Go back to start of loop
return:
    # return counter;
# }
    ori  $s0,$t2,0   # Copy counter to return register
    jr   $ra         # Return

# Jump table
.data
.align 2
test_table:
    .word 0
    .word 3
    .word 0
    .word 1
    .word -3
table:
    .word 0
    .word 0
    .word 2
    .word 0
    .word 0
    .word 0
    .word -5
    .word -5
    .word -4
    .word 1
    .word -5
    .word 1
    .word -1
    .word -7
    .word -1
    .word -2
    .word -14
    .word -5
    .word -5
    .word -4
    .word 1
    .word 0
    .word -9
    .word 2
    .word -4
    .word -1
    .word -18
    .word -3
    .word -12
    .word -10
    .word -22
    .word -18
    .word -28
    .word -11
    .word -33
    .word 0
    .word -22
    .word -14
    .word 2
    .word -1
    .word -14
    .word -4
    .word -5
    .word -40
    .word -33
    .word -38
    .word -12
    .word -29
    .word -47
    .word -14
    .word 2
    .word -34
    .word -26
    .word -10
    .word -47
    .word -20
    .word -24
    .word -12
    .word -12
    .word -39
    .word -43
    .word -56
    .word -36
    .word -52
    .word -38
    .word -8
    .word -53
    .word -53
    .word -31
    .word -29
    .word -53
    .word -20
    .word -71
    .word -14
    .word -61
    .word -25
    .word -70
    .word -37
    .word -32
    .word -30
    .word -10
    .word -78
    .word -42
    .word -59
    .word -40
    .word -19
    .word -41
    .word -40
    .word -81
    .word -9
    .word -69
    .word -49
    .word -39
    .word -12
    .word -6
    .word -18
    .word -93
    .word -14
    .word -46
    .word -88
    .word -72
    .word -84
    .word -51
    .word -79
    .word -23
    .word -96
    .word -72
    .word -73
    .word -38
    .word -19
    .word -7
    .word -90
    .word -37
    .word -28
    .word -18
    .word -84
    .word -42
    .word -115
    .word -33
    .word -100
    .word -99
    .word -50
    .word -37
    .word -90
    .word -60
    .word -19
    .word -59
    .word -107
    .word 0
    .word -78
    .word -40
    .word -82
    .word -114
    .word -33
    .word -24
    .word -105
    .word -22
    .word -20
    .word -39
    .word -45
    .word 0
    .word -78
    .word -40
    .word -25
    .word -78
    .word -18
    .word -122
    .word -76
    .word -123
    .word -128
    .word -88
    .word -118
    .word 2
    .word -65
    .word -115
    .word -70
    .word -6
    .word -83
    .word -113
    .word 0
    .word -102
    .word -142
    .word -34
    .word -74
    .word -101
    .word -43
    .word -112
    .word -37
    .word -126
    .word -149
    .word -28
    .word -15
    .word -28
    .word -123
    .word -36
    .word -75
    .word -54
    .word -141
    .word -77
    .word -13
    .word -91
    .word -53
    .word -168
    .word -70
    .word -149
    .word -80
    .word -111
    .word -83
    .word -48
    .word -100
    .word -111
    .word -90
    .word -87
    .word -42
    .word -54
    .word -147
    .word -131
    .word -24
    .word -24
    .word -128
    .word -145
    .word -58
    .word -164
    .word -137
    .word -116
    .word -118
    .word -152
    .word -110
    .word -15
    .word 0
    .word -185
    .word -200
    .word -137
    .word -80
    .word -174
    .word -4
    .word -172
    .word -76
    .word -51
    .word -37
    .word -118
    .word -206
    .word -134
    .word -117
    .word -102
    .word -5
    .word -176
    .word -8
    .word -217
    .word -124
    .word -1
    .word -95
    .word -217
    .word -64
    .word -192
    .word -230
    .word -209
    .word -111
    .word -133
    .word -118
    .word -213
    .word -198
    .word -199
    .word -161
    .word -225
    .word -2
    .word -239
    .word -162
    .word -121
    .word -36
    .word -213
    .word -153
    .word -19
    .word -178
    .word -52
    .word -60
    .word -182
    .word -92
    .word -186
    .word -43
    .word 0
    .word -202
    .word -73
    .word -150
    .word -152
    .word -72
    .word -181
    .word -190
    .word -26
    .word -110
    .word -100
    .word -82
    .word -265
    .word -77
    .word 2
    .word -270
    .word -42
    .word -98
    .word -91
    .word -130
    .word -7
    .word -186
    .word -222
    .word -12
    .word -26
    .word -97
    .word -216
    .word -130
    .word -201
    .word -52
    .word -220
    .word -245
    .word -263
    .word -195
    .word -68
    .word -209
    .word -6
    .word -89
    .word -161
    .word -246
    .word -123
    .word -212
    .word -153
    .word -99
    .word -227
    .word -171
    .word -146
    .word -48
    .word -105
    .word -252
    .word -169
    .word -135
    .word -7
    .word -49
    .word -231
    .word -146
    .word -40
    .word -31
    .word -233
    .word -1
    .word -245
    .word -251
    .word -228
    .word -33
    .word -58
    .word -1
    .word -154
    .word -162
    .word -192
    .word -179
    .word -212
    .word -51
    .word -316
    .word -96
    .word -210
    .word -237
    .word -198
    .word -335
    .word -136
    .word 1
    .word -144
    .word -60
    .word -116
    .word -61
    .word -44
    .word -105
    .word -80
    .word -324
    .word -54
    .word -282
    .word -282
    .word -240
    .word -73
    .word -303
    .word -114
    .word -96
    .word -149
    .word -301
    .word -201
    .word -104
    .word -286
    .word -358
    .word -288
    .word -352
    .word -8
    .word -134
    .word -358
    .word -90
    .word -30
    .word -234
    .word -243
    .word -367
    .word -157
    .word -162
    .word -119
    .word -265
    .word -340
    .word -334
    .word -11
    .word -206
    .word -311
    .word -246
    .word -34
    .word -145
    .word -183
    .word -333
    .word -311
    .word -271
    .word -299
    .word -39
    .word -316
    .word -144
    .word -269
    .word -255
    .word -192
    .word -269
    .word -111
    .word -295
    .word -236
    .word -115
    .word -26
    .word -303
    .word -16
    .word -56
    .word -150
    .word -267
    .word -252
    .word -196
    .word -148
    .word -363
    .word -322
    .word -178
    .word -136
    .word -205
    .word -115
    .word -18
    .word -410
    .word -8
    .word -196
    .word -16
    .word -59
    .word -79
    .word -300
    .word -101
    .word -242
    .word -374
    .word -21
    .word -201
    .word -106
    .word -204
    .word -53
    .word -8
    .word -33
    .word -323
    .word -172
    .word -8
    .word -240
    .word -255
    .word 0
    .word -178
    .word -384
    .word -177
    .word -254
    .word -120
    .word -277
    .word -109
    .word -417
    .word -360
    .word -19
    .word -236
    .word -87
    .word -184
    .word -176
    .word -405
    .word -252
    .word -274
    .word -366
    .word -107
    .word -201
    .word -62
    .word -407
    .word -130
    .word -288
    .word -382
    .word -319
    .word -463
    .word -82
    .word -187
    .word -242
    .word -142
    .word -400
    .word -37
    .word -315
    .word -407
    .word -384
    .word -413
    .word -51
    .word -303
    .word -318
    .word -401
    .word -222
    .word -219
    .word -20
    .word -446
    .word -33
    .word -105
    .word -322
    .word -177
    .word -18
    .word -212
    .word -31
    .word -370
    .word -247
    .word -87
    .word -428
    .word -22
    .word -74
    .word -108
    .word -6
    .word -49
    .word -242
    .word -298
    .word -266
    .word -500
    .word -359
    .word -24
    .word -465
    .word -137
    .word -344
    .word -47
    .word -268
    .word -240
    .word -92
    .word -463
    .word -311
    .word -107
    .word -143
    .word -319
    .word -409
    .word -158
    .word -267
    .word -447
    .word -140
    .word -323
    .word -351
    .word -471
    .word -381
    .word -433
    .word -3
    .word -396
    .word -386
    .word -269
    .word -244
    .word -201
    .word -379
    .word -534
    .word -140
    .word -278
    .word -222
    .word -511
    .word -182
    .word -65
    .word -104
    .word -21
    .word -336
    .word -418
    .word -303
    .word -169
    .word 0
    .word -31
    .word -99
    .word -449
    .word -429
    .word -91
    .word -471
    .word 0
    .word -284
    .word -320
    .word -32
    .word -161
    .word -548
    .word -126
    .word -173
    .word -138
    .word -411
    .word -477
    .word -11
    .word -399
    .word -388
    .word -427
    .word -450
    .word -262
    .word -48
    .word -372
    .word -254
    .word -535
    .word -36
    .word -452
    .word -545
    .word -289
    .word -339
    .word -314
    .word -455
    .word -146
    .word -271
    .word -274
    .word -103
    .word -109
    .word -565
    .word -114
    .word -373
    .word -517
    .word -453
    .word -184
    .word -216
    .word -314
    .word -75
    .word -401
    .word -411
    .word -117
    .word -2
    .word -417
    .word -449
    .word -146
    .word -252
    .word -560
    .word -232
    .word -222
    .word -462
    .word -133
    .word -410
    .word -323
    .word -431
    .word -272
    .word -49
    .word -256
    .word -332
    .word -342
    .word -270
    .word -186
    .word -275
    .word -179
    .word -335
    .word -613
    .word -149
    .word -489
    .word -334
    .word -415
    .word -401
    .word -582
    .word -306
    .word -383
    .word -478
    .word -65
    .word -171
    .word -554
    .word -24
    .word -261
    .word -628
    .word -298
    .word -20
    .word -511
    .word -459
    .word -507
    .word -278
    .word -194
    .word -89
    .word -391
    .word -346
    .word -472
    .word -268
    .word -281
    .word -326
    .word -259
    .word -452
    .word -470
    .word -311
    .word -401
    .word -234
    .word -154
    .word -511
    .word -34
    .word -445
    .word -25
    .word -322
    .word -143
    .word -35
    .word -267
    .word -181
    .word -132
    .word -235
    .word -653
    .word -78
    .word -193
    .word -353
    .word -591
    .word -575
    .word -296
    .word -160
    .word -533
    .word -203
    .word -468
    .word -266
    .word -373
    .word -562
    .word -550
    .word -555
    .word -39
    .word -100
    .word -338
    .word -82
    .word -323
    .word -200
    .word -388
    .word -185
    .word -260
    .word -413
    .word -161
    .word -516
    .word -169
    .word -437
    .word -296
    .word -232
    .word -171
    .word -25
    .word -237
    .word -125
    .word -74
    .word -506
    .word -5
    .word -494
    .word -270
    .word -526
    .word -3
    .word -463
    .word -505
    .word -170
    .word -7
    .word -321
    .word -22
    .word -605
    .word -220
    .word -115
    .word -158
    .word -509
    .word -560
    .word -195
    .word -292
    .word -632
    .word -101
    .word -374
    .word -60
    .word -36
    .word -142
    .word -617
    .word -723
    .word -114
    .word -709
    .word -536
    .word -308
    .word -513
    .word -680
    .word -256
    .word -111
    .word -27
    .word -497
    .word -20
    .word -46
    .word -108
    .word -385
    .word -412
    .word -262
    .word -509
    .word -34
    .word -101
    .word -139
    .word -73
    .word -208
    .word -192
    .word -625
    .word -206
    .word -273
    .word -416
    .word -263
    .word -316
    .word -417
    .word -378
    .word -126
    .word -631
    .word -195
    .word -191
    .word -152
    .word -503
    .word -84
    .word -110
    .word -529
    .word -702
    .word -136
    .word -83
    .word -125
    .word -658
    .word -223
    .word -16
    .word -23
    .word -681
    .word -535
    .word -599
    .word -587
    .word -612
    .word -377
    .word -701
    .word -479
    .word -396
    .word -556
    .word -608
    .word -548
    .word -474
    .word -704
    .word -19
    .word -590
    .word -512
    .word -643
    .word -121
    .word -440
    .word -400
    .word -638
    .word -360
    .word -790
    .word -225
    .word -617
    .word -361
    .word -14
    .word -259
    .word -465
    .word -689
    .word -421
    .word -480
    .word -386
    .word -416
    .word -804
    .word -145
    .word -661
    .word -679
    .word -158
    .word -622
    .word -130
    .word -380
    .word -50
    .word -677
    .word -375
    .word -795
    .word -423
    .word -727
    .word -231
    .word -125
    .word -363
    .word -77
    .word -825
    .word -363
    .word -557
    .word -61
    .word -109
    .word -368
    .word -434
    .word -826
    .word -347
    .word -174
    .word -638
    .word -645
    .word -210
    .word -655
    .word -314
    .word -549
    .word -26
    .word -467
    .word -59
    .word -233
    .word -21
    .word -212
    .word -682
    .word -551
    .word -285
    .word -53
    .word -690
    .word -391
    .word -655
    .word -416
    .word -247
    .word -621
    .word 0
    .word -160
    .word -252
    .word -329
    .word -270
    .word -213
    .word -489
    .word -681
    .word -388
    .word -142
    .word -660
    .word -157
    .word -102
    .word -876
    .word -568
    .word -411
    .word -234
    .word -490
    .word -166
    .word -105
    .word -743
    .word -759
    .word -196
    .word -127
    .word -358
    .word -100
    .word -272
    .word -107
    .word -186
    .word -742
    .word -440
    .word -520
    .word -272
    .word -822
    .word -224
    .word -613
    .word -53
    .word -295
    .word -511
    .word -292
    .word -420
    .word -298
    .word -127
    .word -490
    .word -117
    .word -240
    .word -277
    .word -683
    .word -37
    .word -447
    .word -671
    .word -646
    .word -562
    .word -228
    .word -341
    .word -725
    .word -797
    .word -350
    .word -648
    .word -164
    .word -660
    .word -424
    .word -295
    .word -855
    .word -213
    .word -773
    .word -733
    .word -526
    .word -339
    .word -43
    .word -657
    .word -361
    .word -224
    .word -85
    .word -188
    .word -750
    .word -377
    .word -836
    .word -311
    .word -550
    .word -71
    .word -627
    .word -719
    .word -514
    .word -923
    .word -599
    .word -166
    .word -431
    .word -706
    .word -413
    .word -444
    .word -359
    .word -811
    .word -81
    .word -738
    .word -120
    .word -127
    .word -191
    .word -592
    .word -420
    .word -466
    .word -863
    .word -441
    .word -338
    .word -99
    .word -838
    .word -835
    .word -418
    .word -162
    .word -368
    .word -511
    .word -35
    .word -146
    .word -457
    .word -176
    .word -778
    .word -508
    .word -706
    .word -729
    .word -188
    .word -904
    .word -706
    .word -441
    .word -399
    .word -790
    .word -932
    .word -805
    .word -462
    .word -387
    .word -17
    .word -661
    .word -714
    .word -93
    .word -741
    .word -979
    .word -96
    .word -791
    .word -830
    .word -177
    .word -73
    .word -309
    .word -497
    .word -47
    .word -451
    .word -628
    .word -215
    .word -631
    .word 0
    .word -98
    .word -938
    .word -138
    .word -129
    .word -164
    .word -387
    .word -668
    .word -534
    .word -679
    .word -537
    .word -589
    .word -828
    .word -815
    .word -876
    .word -403
    .word -27
