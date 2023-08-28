/*
Source: https://stackoverflow.com/questions/69521375/system-verilog-randomization-per-instance-at-initial
*/

package seed_instance;

int initial_seed = $urandom;

function automatic void srandom(string path);
  static int hash[int];
  int hash_value = initial_seed;
  process p = process::self();
  for(int i=0;i<path.len();i++)
    hash_value+=path[i]*(i*7);
  if (!hash.exists(hash_value))
    hash[hash_value] = hash_value;
  else
    hash[hash_value]+=$urandom; // next seed
  p.srandom(hash[hash_value]);
endfunction

endpackage
