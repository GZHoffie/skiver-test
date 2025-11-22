import pandas as pd
import argparse
import pathlib

def kmer_match_profile(k_min, k_max, best_stats):
    sequence_length_df = pd.read_csv(best_stats + ".summary_sequence_length_stats.csv")
    consecutive_match_df = pd.read_csv(best_stats + ".summary_consecutive_match_stats.csv")


    k_list = []
    matched_kmer_list = []

    for k in range(k_min, k_max + 1):
        # Count the total number of k-mers in the read set
        sequence_length_df['num_kmers'] = sequence_length_df['sequence_length'].apply(
            lambda x: max(0, x - k + 1)
        )
        sequence_length_df['num_kmers'] = sequence_length_df['num_kmers'] * sequence_length_df['count']
        num_kmers = sequence_length_df['num_kmers'].sum()

        # Count the number of matched k-mers based on consecutive matches
        consecutive_match_df['kmer_matches'] = consecutive_match_df['consecutive_match_length'].apply(
            lambda x: max(0, x - k + 1)
        )
        consecutive_match_df['kmer_matches'] = consecutive_match_df['kmer_matches'] * consecutive_match_df['count']
        num_matched_kmers = consecutive_match_df['kmer_matches'].sum()

        k_list.append(k)
        matched_kmer_list.append(num_matched_kmers / num_kmers if num_kmers > 0 else 0)

    return k_list, matched_kmer_list




if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Count mapped k-mers from BAM file against reference.")
    parser.add_argument("-k", "--k_min", type=int, required=True, help="Minimum k-mer size.")
    parser.add_argument("-K", "--k_max", type=int, required=True, help="Maximum k-mer size.")

    parser.add_argument("-b", "--best_stats", type=str, required=True, help="Path to best identity stats CSV files.")
    #parser.add_argument("-o", "--output", type=str, required=True, help="Path to output CSV file.")

    args = parser.parse_args()

    k_list, matched_kmer_list = kmer_match_profile(args.k_min, args.k_max, args.best_stats)

    result_df = pd.DataFrame({
        'k': k_list,
        'num_kmer_hit': matched_kmer_list
    })

    result_df.to_csv(args.best_stats + ".matched_kmers.csv", index=False)