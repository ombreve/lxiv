@default_files = ('lxiv');
$pdf_mode=4;

$cleanup_includes_cusdep_generated = 1;
add_cus_dep('txt', 'tex', 0, 'shuffle');
sub shuffle {
  rdb_ensure_file($rule, 'filter-latex.lua');
  system("./shuffle.sh < $_[0].txt > $_[0].tex");
}
