16.times do
  sample :ambi_glass_hum if look%4 == 0 #requirement 5
  sleep 0.5
end
8.times do
  tick
  sample :ambi_glass_hum if look%4 == 0
  play 40, release: 0.1, cutoff: rrand(20,50) #requirement 6
  sleep 0.5
end
in_thread do
  live_loop :drums do
    tick
    play sample :ambi_glass_hum if look%4 == 0
    play 52 if look%8 == 7
    play 40, release: 0.1, cutoff: rrand(20,30)
    sleep 0.5
  end
end
sleep 4
define :minor_scale do #requirement 4
  play_pattern_timed (scale :e3, :minor_pentatonic, num_octaves: 3), 0.25,
    release: 0.25, amp: 0.5 #requirement 2 & 8
end
live_loop :play do #requirement 1
  tick
  play minor_scale
end
live_loop :play2 do
  with_fx :flanger do #requirement 7
    [1,3,6,4].each do |d|
      (range 0, 4).each do |i|
        play_chord (chord_degree d, :e, :minor, 3, invert: i),amp: 0.4 #requirement 2
        sleep 0.5
      end
    end
  end
end
sleep 8
notes = [76,74,72,71,67,64,66,67,69,76,74,72,71,67,64,72,69].ring
release_times = [2,0.5,0.5,1,1,0.5,0.5,0.5,1.5,2,0.5,0.5,1,0.5,0.5,1].ring
sleep_times= [2,0.5,0.5,1,1,0.5,0.5,0.5,1.5,2,0.5,0.5,1,0.5,0.5,1,2].ring
tick_reset
17.times do
  use_synth :beep #requirement 5
  tick
  play notes.look, release: release_times.look
  sleep sleep_times.look
end
chorus_notes = [71,71,74,74,71,67,64,64,66,67, 67,67,71,71,74,74,71, 67, 72,72,71,67].ring #requirement 2
hold = [0.5,1,0.5,1,0.5,0.5,0.5,1,0.5,1,0.5,0.5,0.5,1,0.5,1,0.5,0.5,0.5,1,0.5,4].ring
rest =[0.5,1,0.5,1,0.5,0.5,0.5,1,0.5,1,0.5,0.5,0.5,1,0.5,1,0.5,0.5,0.5,1,0.5,4].ring
tick_reset
22.times do
  tick #requirement 3
  play chorus_notes.look, release: hold.look;
  sleep rest.look #requirement 3
end
