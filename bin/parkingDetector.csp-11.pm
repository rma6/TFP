// probabilistic translation from /home/mscf/Dropbox/UFPE/RoboTool/workspace/parkingDetector/src-gen/out/parkingDetector.csp-11
// Prop [T= parkingDetector_aux(0) \ {parkingDetector_enter,parkingDetector_entered,parkingDetector_exit,parkingDetector_exited} :[probabilistic translation]

nondeterministic

// implementation has alphabet {|updateCall,increaseSlotCall,decreaseSlotCall,parkingDetector_stuck.out,rotateCall,parkingDetector_true_movement_out.in,parkingDetector_isFalse.out,rotateRet,updateRet,decreaseSlotRet,increaseSlotRet,parkingDetector_false_movement_out.in,parkingDetector_true_movement_in.in,parkingDetector_escape.out,parkingDetector_false_movement_in.in|}

module WATCHDOG

  pc : [0..2] init 0;
  trace_error : bool init false;

  [dummy] false -> (pc'=2);
  [e2] !trace_error & pc!=0 -> 1:(trace_error'=true); // updateCall
  [e2] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // updateCall
  [e5] !trace_error & pc!=0 -> 1:(trace_error'=true); // increaseSlotCall
  [e5] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // increaseSlotCall
  [e6] !trace_error & pc!=0 -> 1:(trace_error'=true); // decreaseSlotCall
  [e6] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // decreaseSlotCall
  [e8] !trace_error & pc!=0 -> 1:(trace_error'=true); // parkingDetector_stuck.out
  [e8] !trace_error & pc=0 -> 1:(pc'=pc=0?1:2); // parkingDetector_stuck.out
  [e9] !trace_error & pc!=0 -> 1:(trace_error'=true); // rotateCall
  [e9] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // rotateCall
  [e10] !trace_error & pc!=0 -> 1:(trace_error'=true); // parkingDetector_true_movement_out.in
  [e10] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // parkingDetector_true_movement_out.in
  [e11] !trace_error & pc!=0 -> 1:(trace_error'=true); // parkingDetector_isFalse.out
  [e11] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // parkingDetector_isFalse.out
  [e12] !trace_error & pc!=0 -> 1:(trace_error'=true); // rotateRet
  [e12] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // rotateRet
  [e13] !trace_error & pc!=0 -> 1:(trace_error'=true); // updateRet
  [e13] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // updateRet
  [e14] !trace_error & pc!=0 -> 1:(trace_error'=true); // decreaseSlotRet
  [e14] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // decreaseSlotRet
  [e15] !trace_error & pc!=0 -> 1:(trace_error'=true); // increaseSlotRet
  [e15] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // increaseSlotRet
  [e17] !trace_error & pc!=0 -> 1:(trace_error'=true); // parkingDetector_false_movement_out.in
  [e17] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // parkingDetector_false_movement_out.in
  [e18] !trace_error & pc!=0 -> 1:(trace_error'=true); // parkingDetector_true_movement_in.in
  [e18] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // parkingDetector_true_movement_in.in
  [e19] !trace_error & pc!=0 -> 1:(trace_error'=true); // parkingDetector_escape.out
  [e19] !trace_error & pc=0 -> 1:(pc'=pc=0?0:2); // parkingDetector_escape.out
  [e637] !trace_error -> (trace_error'=true); // parkingDetector_false_movement_in.in

endmodule

module P_0

  pc_0: [0..30] init 0;

  [dummy] false -> (pc'=30);
  [] !trace_error & pc_0=24 -> 0.7:(pc_0'=11) + 0.3:(pc_0'=23); // _prob.0
  [e2] !trace_error & pc_0=0,28,29 -> 1:(pc_0'=pc_0=0,28,29?14:30); // updateCall
  [e2] !trace_error & pc_0=0,28,29 -> 1:(pc_0'=pc_0=0,28,29?15:30); // updateCall
  [e5] !trace_error & pc_0=1..4 -> 1:(pc_0'=pc_0=1?19:pc_0=2?20:pc_0=3?21:pc_0=4?22:30); // increaseSlotCall
  [e6] !trace_error & pc_0=5..7 -> 1:(pc_0'=pc_0=5?16:pc_0=6?17:pc_0=7?18:30); // decreaseSlotCall
  [e8] !trace_error & pc_0=8,23,25 -> 1:(pc_0'=pc_0=8,23,25?8:30); // parkingDetector_stuck.out
  [e9] !trace_error & pc_0=9,10 -> 1:(pc_0'=pc_0=9?12:pc_0=10?13:30); // rotateCall
  [e10] !trace_error & pc_0=26..29 -> 1:(pc_0'=pc_0=26,28?1:pc_0=27,29?2:30); // parkingDetector_true_movement_out.in
  [e11] !trace_error & pc_0=11,25 -> 1:(pc_0'=pc_0=11,25?0:30); // parkingDetector_isFalse.out
  [e12] !trace_error & pc_0=12,13 -> 1:(pc_0'=pc_0=12?26:pc_0=13?27:30); // rotateRet
  [e13] !trace_error & pc_0=14,15 -> 1:(pc_0'=pc_0=14?9:pc_0=15?10:30); // updateRet
  [e14] !trace_error & pc_0=16..18 -> 1:(pc_0'=pc_0=18?25:pc_0=16?28:pc_0=17?29:30); // decreaseSlotRet
  [e15] !trace_error & pc_0=19..22 -> 1:(pc_0'=pc_0=22?24:pc_0=21?25:pc_0=19?28:pc_0=20?29:30); // increaseSlotRet
  [e17] !trace_error & pc_0=26..29 -> 1:(pc_0'=pc_0=26,28?3:pc_0=27,29?4:30); // parkingDetector_false_movement_out.in
  [e18] !trace_error & pc_0=26..29 -> 1:(pc_0'=pc_0=26,28?5:pc_0=27,29?6:30); // parkingDetector_true_movement_in.in
  [e19] !trace_error & pc_0=23,25 -> 1:(pc_0'=pc_0=23,25?0:30); // parkingDetector_escape.out
  [e637] !trace_error & pc_0=26..29 -> 1:(pc_0'=pc_0=26..29?7:30); // parkingDetector_false_movement_in.in

endmodule

system

  WATCHDOG
||
  P_0

endsystem
