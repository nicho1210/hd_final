set mode "all"
if { $argc >= 1 } {
    set mode [lindex $argv 0]
}

puts "Running HLS flow mode: $mode"

open_project -reset video_gray_live_prj
set_top video_gray_live

add_files video_ip.cpp
add_files video_ip.h
add_files -tb tb_video_ip.cpp

open_solution -reset "solution1"
set_part {xc7z020clg400-1}
create_clock -period 10

if { $mode == "csim" || $mode == "all" } {
    puts "Running C simulation..."
    csim_design
}

if { $mode == "synth" || $mode == "all" } {
    puts "Running C synthesis..."
    csynth_design
}

exit